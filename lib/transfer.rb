class Transfer

  attr_reader :amount, :sender, :receiver
  attr_accessor :status

  def initialize(sender, receiver, amount)
    @status = "pending"
    @sender = sender
    @receiver = receiver
    @amount = amount
    @amount_save = amount
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if valid? && sender.balance > amount && sender.status = "open" 
    sender.balance -= @amount
    receiver.balance += @amount
    @amount = 0
    @status = "complete"
    else
    self.status = "rejected"
    "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @status == "complete"
      @sender.balance += @amount_save
      @receiver.balance -= @amount_save
      @status = "reversed"
    end
  end

end
