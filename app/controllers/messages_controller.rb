class MessagesController < ApplicationController


  def index
    @messages = Message.all
  end

  def create
    @message = Message.new(params[:message])
    if @message.save
      puts "---"*90
      # require 'nexmo'
      # nexmo = Nexmo::Client.new('c6ec048a', 'c86f0b89')
      # response = nexmo.send_message({:to => "#{@message.number}", :from => 'Decent Acad.', :text => 'Classes of 9th & 10th are starting under the fully attention of  Faisal Bhatti [software Eng @Devsinc(pvt Ltd), Principal ] and Dr Maimoona(KEMU).For Further details Contact at 03324167729. Decent Academy'})
      # puts response.inspect

      # require 'twilio-ruby'
      # account_sid = 'ACa31d8423032237dcfb631b4f6fc700e1'
      # auth_token = '9fcc1ee7920f62dd6d16bd746614fdb9'
      # @client = Twilio::REST::Client.new account_sid, auth_token
      # rsponse = @client.messages.create(
      #   from: '+14792085406',    #+18704667180
      #   to: '+923324167729',
      #   body: 'Classes of 9th & 10th are starting under the fully attention of  Faisal Bhatti [software Eng @Devsinc(pvt Ltd), Principal ] and Dr Maimoona(KEMU).For Further details Contact at 03324167729. Decent Academy'
      # )
      # puts rsponse.inspect


      require 'clockwork'
      api = Clockwork::API.new('26b9fa95254aa50ada2e514fbd324147e2c88f6a')
      message = api.messages.build( :to => '+923324167729', :from=>"Decent Acad", :content => 'Test Session of 9th & 10th are started. Contact at 03324167729. Decent Academy' )
      response = message.deliver
       
      if response.success
          puts response.message_id
      else
          puts response.error_code
          puts response.error_description
      end
    else
      puts "=="*90
    end
    flash[:message] = "Sms send to #{@message.name}"
    redirect_to root_path
    end

   def new
     @message = Message.new
   end

   def destroy
     @message = Message.find(params[:id])
     @message.destroy
     redirect_to root_path
   end
  def sms_database
    require 'nexmo'
    # key = c6ec048a
    #secret = c86f0b89
    nexmo = Nexmo::Client.new('0c6ad999', 'abdd4626')
      @messages = Message.all
      @messages.each do |message|
        response = nexmo.send_message({:to => "#{message.number}", :from => 'Decent Acad.', :text => 'Classes of 9th & 10th are starting under the fully attention of  Faisal Asghar Bhatti [software Eng @Devsinc(pvt Ltd), Principal ] and Dr Maimoona Asghar(KEMU).For Further details Contact at 03324167729. Decent Academy'})
      end
    flash[:message] = "Sms sent to all"
     redirect_to root_path
  end

  def add_receiver
    @message = Message.new(params[:message])
    if @message.save
      flash[:message] = "Successfully Added..."
      redirect_to root_path
    end
  end

  def new_receiver
    @message = Message.new
  end

end
