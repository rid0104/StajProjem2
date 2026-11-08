from pydantic import BaseModel,Field,ConfigDict


class BaseSchema(BaseModel):
    model_config=ConfigDict(from_attributes=True)

class UserCreate(BaseModel):
    email:str
    kullaniciadi:str 
    password: str = Field(min_length=4)

class LoginRequest(BaseModel):
    username: str
    password: str

class UserResponse(BaseModel):
    id:int
    email:str
    kullaniciadi:str


    class Config:
        from_attributes=True

