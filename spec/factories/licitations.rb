# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :licitation do
    url "MyString"
    visited false
    parsed false
    category_id 1
    compra_type "MyString"
    entidad "MyString"
    dependencia "MyString"
    nombre_contacto "MyString"
    telefono_contacto "MyString"
    correo_contacto "MyString"
    objeto "MyString"
    modalidad "MyString"
    unidad "MyString"
    provincia "MyString"
    precio "9.99"
    proponente "MyString"
    description "MyText"
    acto "MyString"
    fecha "2013-10-14 01:47:04"
  end
end
