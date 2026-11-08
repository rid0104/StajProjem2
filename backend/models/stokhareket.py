from backend.core.enums import MovementType
from sqlalchemy import ForeignKey, Float, Integer, String
from sqlalchemy.orm import Mapped, mapped_column, relationship
from sqlalchemy import Column
from sqlalchemy import Enum as SqlEnum
from .base import BaseModel


class Stokhareket(BaseModel):
    __tablename__ = "stokhareketleri"

    entitytype = mapped_column("entitytype", String(50), nullable=False)
    harekettipi = mapped_column("harekettipi", SqlEnum(MovementType), nullable=False)
    entity_id: Mapped[int] = mapped_column(Integer, nullable=False)


    miktar: Mapped[float] = mapped_column(Float, nullable=False)
    oncekistok: Mapped[float] = mapped_column(Float, nullable=False)
    sonrakistok: Mapped[float] = mapped_column(Float, nullable=False)

    aciklama: Mapped[str | None] = mapped_column(String(255), nullable=True)