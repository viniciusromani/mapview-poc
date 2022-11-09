import Combine

protocol UserDataSource {
    func store(_ user: UserModel) -> Future<Bool, Error>
    func get() -> Future<UserModel?, Error>
    func delete(_ user: UserModel) -> Future<Bool, Error>
}
