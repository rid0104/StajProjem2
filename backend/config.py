from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    APP_NAME: str = "DepoKontrol"
    
    # Eksik olan JWT ayarları (Production'da SECRET_KEY değerini değiştirin)
    SECRET_KEY: str = "9c685b2eeabb6934f8ddbabfa4e006018c355df83814e5a250dd184cd3368882"
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 30

settings = Settings()