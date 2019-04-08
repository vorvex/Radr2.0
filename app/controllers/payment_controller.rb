class PaymentController < ApplicationController 
  skip_before_action :verify_authenticity_token
  layout 'dashboard'
  before_action :start

  def customer_updated   
    customer_id = params[:data][:object][:id]
    email = params[:data][:object][:email]
    name = params[:data][:object][:sources][:data].first[:name]
    exp_month = params[:data][:object][:sources][:data].first[:card][:exp_month]
    exp_year = params[:data][:object][:sources][:data].first[:card][:exp_year]
    last4 = params[:data][:object][:sources][:data].first[:card][:last4]
    brand = params[:data][:object][:sources][:data].first[:card][:brand]
    fingerprint = params[:data][:object][:sources][:data].first[:card][:fingerprint]
    
    @user = User.find_by_email(email)
    @user.update(cc_name: name, cc_exp_year: exp_year, cc_exp_month: exp_month, cc_last_four: last4, cc_brand: brand, cc_fingerprint: fingerprint, customer_id: customer_id)
      
    if params[:data][:object][:subscriptions][:total_count] > 0
      nickname = params[:data][:object][:subscriptions][:data].first[:items][:data].first[:plan][:nickname]
      subscription_id = params[:data][:object][:subscriptions][:data].first[:id]      
      @user.subscription_id = subscription_id
      @user.plan = nickname
      @user.onboarding = true
    end
    
    if @user.save!
      respond_to do |format|
        format.js { render :status => 200 }
      end
    end
    
  end
  
  def charge

#    endpoint_secret = "whsec_ojCwCCT2ucIlJoEAuqB3iBxP6ATO2LRN"
#    
#    payload = request.body.read
#    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
#    event = nil
#
#    begin
#        event = Stripe::Webhook.construct_event(
#            payload, sig_header, endpoint_secret
#        )
#    rescue JSON::ParserError => e
#
#        return
#    rescue Stripe::SignatureVerificationError => e
#
#        return
#    end
    
    customer_id = params[:data][:object][:customer]
    @user = User.find_by_customer_id(customer_id)

    if params[:type] == "charge.failed" && !@user.nil?
      if !@user.locked
        @user.update(locked: true)
        # Send Email to User => "Die letzte Bezahlung wurde abgelehnt. Ihr Akkount wurde gesperrt! Bitte kontaktieren Sie den Kunden-Support"
      end
    elsif params[:type] == "charge.succeeded" && !@user.nil?
      if @user.locked
        @user.update(locked: false)        
        # Send Email to User => "Ihr Akkount wurde erfolgreich freigeschaltet"
      end
    end  
  end
  
  def invoice_created
    Time.zone = "Berlin"    
    customer_id = params[:object][:customer]
    invoice_pdf = params[:object][:invoice_pdf]
    invoice_url = params[:object][:hosted_invoice_url]
    date = Time.zone.at(params[:object][:date].to_i)
    amount_due = params[:object][:amount_due].to_i
    amount_paid = params[:object][:amount_paid].to_i
    
    paid_for_till = Time.zone.at(params[:object][:lines][:data].first[:period][:end].to_i)
    
    user = User.find_by_customer_id(customer_id)
    
    user.update(paid_for_till: paid_for_till)
    
    @invoice = Invoice.create(user: user, url: invoice_url, pdf: invoice_pdf, date: date, amount_due: amount_due, amount_paid: amount_paid)
    
    # Wenn Rechnungen per Email senden = TRUE sende Email an Nutzer mit "Ihre Rechnung von @invoice.date"
    if user.bill_per_email
      UserMailer.with(user: @user, invoice: @invoice).invoice_email.deliver_now
    end
    
  end
  
  def select_abo
    Stripe.api_version = "2018-11-08; checkout_sessions_beta=v1"
    
    @user = current_user
    success = 'https://radr2.herokuapp.com/success'
    cancel = 'https://radr2.herokuapp.com/cancel'
    
      
        @gold_session = Stripe::Checkout::Session.create({
          success_url: success,
          cancel_url: cancel,
          payment_method_types: ["card"],
          subscription_data: {
            items: [{plan: 'plan_EpdLj7YLuOWOcV', quantity: 1}]
          },
          client_reference_id: @user.id,
          customer_email: @user.email 
        })

        @platin_session = Stripe::Checkout::Session.create({
          success_url: success,
          cancel_url: cancel,
          payment_method_types: ["card"],
          subscription_data: {
            items: [{plan: 'plan_EpdMH7qCZFUsYR', quantity: 1}]
          },
          client_reference_id: @user.id,
          customer_email: @user.email 
        })
  end
  
  def plans
    Stripe.api_version = "2018-11-08; checkout_sessions_beta=v1"
    
    @user = current_user
    success = 'https://radr2.herokuapp.com/success'
    cancel = 'https://radr2.herokuapp.com/cancel'
    
      
        @gold_session = Stripe::Checkout::Session.create({
          success_url: success,
          cancel_url: cancel,
          payment_method_types: ["card"],
          subscription_data: {
            items: [{plan: 'plan_EpdLj7YLuOWOcV', quantity: 1}]
          },
          client_reference_id: @user.id,
          customer_email: @user.email 
        })

        @platin_session = Stripe::Checkout::Session.create({
          success_url: success,
          cancel_url: cancel,
          payment_method_types: ["card"],
          subscription_data: {
            items: [{plan: 'plan_EpdMH7qCZFUsYR', quantity: 1}]
          },
          client_reference_id: @user.id,
          customer_email: @user.email 
        })
    
  end
  
  def success
    @user = current_user

    redirect_to "/"
  end
  
  def cancel
    @user = current_user
    
    redirect_to "/"
  end
  
private
  
  def start
    require "stripe"
    Stripe.api_key = 'sk_test_Hid6fekIA4GKe3mxwr9YmtAR'
  end

end
