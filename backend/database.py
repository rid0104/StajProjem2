import os  #işletim sistemiyle iletişim kurulmasını sağlar.
from dotenv import load_dotenv #proje klasöründeki  gizli dosya olan.envin içindeki ayarları okur ve sisteme yükler. 
from sqlalchemy import create_engine # createengine pythonla veritabanı arasındaki bağlantıyı sağlayan köprüdür.
from sqlalchemy.orm import sessionmaker,declarative_base
#sessionmaker veritabanıyla yapılacak işlemler için bir oturum oluşturur.
#tıpkı vezne gibi tüm işlemler silme,güncelleme bu oturumda yürütülür.

#declarativebase veritabanındaki tabloları python sınıfları olarak tanımlamamaızı sağlayan temel sınıftır.

"""
Neden kullanılır? Şifrelerinizi GitHub gibi platformlara yanlışlıkla yüklemenizi engeller ve farklı
 bilgisayarlarda farklı ayarlar (yerel veritabanı vs. canlı veritabanı) kullanmanızı kolaylaştırır.

 Örnek Bir Senaryo
Kodun nasıl bir araya geldiğini şu küçük akışta görebilirsiniz:

load_dotenv() çağrılır; .env dosyasındaki gizli veritabanı şifresi okunur.

os.getenv("DB_URL") ile bu şifre alınır.

create_engine bu URL'yi kullanarak veritabanına bağlanır.

declarative_base ile bir User sınıfı oluşturulur (bu, veritabanındaki "users" tablosudur).

sessionmaker ile oluşturulan oturum sayesinde, yeni bir kullanıcı eklemek için sadece session.add(yeni_kullanici) yazmanız yeterli olur; SQLAlchemy bunu arka planda SQL'e çevirir.

Bu yapı, kodunuzun daha temiz, güvenli ve veritabanı türünden bağımsız (SQLite'dan PostgreSQL'e geçmek çok kolaydır) olmasını sağlar
"""

load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL")
engine=create_engine(
    DATABASE_URL,
    pool_pre_ping=True
)

SessionLocal = sessionmaker(
    autocommit=False,
    autoflush=False,
    bind=engine
)

Base = declarative_base()

def get_db():
    db=SessionLocal()
    try:
        yield db
    finally:
        db.close()

def create_table():
    Base.metadata.create_all(bind=engine)


