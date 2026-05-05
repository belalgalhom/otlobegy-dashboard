import 'package:test/test.dart';
import 'package:otlob_api/otlob_api.dart';


/// tests for VendorsWalletTransactionsApi
void main() {
  final instance = OtlobApi().getVendorsWalletTransactionsApi();

  group(VendorsWalletTransactionsApi, () {
    // Get any vendor's wallet balance (Admin)
    //
    //Future vendorWalletControllerAdminGetBalance(String vendorId) async
    test('test vendorWalletControllerAdminGetBalance', () async {
      // TODO
    });

    // List any vendor's wallet transactions (Admin)
    //
    //Future vendorWalletControllerAdminListTransactions(String vendorId, { String type, String from, String to, num page, num limit }) async
    test('test vendorWalletControllerAdminListTransactions', () async {
      // TODO
    });

    // Get vendor wallet balance (Member)
    //
    //Future vendorWalletControllerGetBalance(String vendorId) async
    test('test vendorWalletControllerGetBalance', () async {
      // TODO
    });

    // List vendor wallet transactions (Member)
    //
    //Future vendorWalletControllerListTransactions(String vendorId, { String type, String from, String to, num page, num limit }) async
    test('test vendorWalletControllerListTransactions', () async {
      // TODO
    });

  });
}
