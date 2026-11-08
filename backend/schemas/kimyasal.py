from pydantic import BaseModel,Field,ConfigDict
from datetime import datetime
class BaseSchema(BaseModel):
    model_config=ConfigDict(from_attributes=True)

class KimyasalBase(BaseModel):
    kimyasalkodu:int
    kimyasaladi:str
    kategori:str
    birim:str
    stokmiktari:float = Field(ge=0)
    minimumstok:int
    tedarikci:str
    sonkullanmatarihi:datetime
    tehlikesinifi:str
    depolokasyonu:str

class KimyasalCreate(KimyasalBase):
    pass

class KimyasalResponse(KimyasalBase, BaseSchema):
    id: int
    is_deleted: bool
    giristarihi: datetime
    guncellemetarihi: datetime
    class Config:
        from_attributes = True