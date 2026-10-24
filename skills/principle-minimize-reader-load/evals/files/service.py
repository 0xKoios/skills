from dataclasses import dataclass


@dataclass
class User:
    id: int
    email: str
    active: bool


_DB = {1: User(1, "a@example.com", True), 2: User(2, "b@example.com", False)}


class UserRepository:
    def find(self, user_id):
        return _DB.get(user_id)


class UserRepositoryAdapter:
    """Wraps UserRepository. Only implementation, only used by UserService."""

    def __init__(self, repo):
        self._repo = repo

    def find(self, user_id):
        return self._repo.find(user_id)


def _lookup_user(adapter, user_id):
    return adapter.find(user_id)


def _is_active(user):
    return user is not None and user.active


class UserService:
    def __init__(self):
        self._adapter = UserRepositoryAdapter(UserRepository())

    def get_active_email(self, user_id):
        user = _lookup_user(self._adapter, user_id)
        if _is_active(user):
            return user.email
        return None
