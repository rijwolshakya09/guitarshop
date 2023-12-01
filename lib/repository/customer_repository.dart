import '../api/customer_api.dart';
import '../model/customer.dart';

class CustomerRepository {
  Future<bool> registerUser(Customer customer) async {
    return await CustomerAPI().registerUser(customer);
  }

  Future<bool> login(String username, String password) {
    return CustomerAPI().login(username, password);
  }
}
