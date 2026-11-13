class UserSettings {
  final String name;
  final String address;
  final String email;
  final String patronNumber;
  final bool receiveNewsletter;

  const UserSettings({
    this.name = '',
    this.address = '',
    this.email = '',
    this.patronNumber = '',
    this.receiveNewsletter = false,
  });
}