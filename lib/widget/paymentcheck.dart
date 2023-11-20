class PaymentStatusChecker {
  double charges;
  double balance;

  PaymentStatusChecker(this.charges, this.balance);

  String checkPaymentStatus() {
    if (charges == balance) {
      return 'Unpaid';
    } else if ((charges > balance) && balance != 0 ) {
      return 'Deposit';
    } else {
      return 'Paid';
    }
  }
}
