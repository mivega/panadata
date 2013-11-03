# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :corporation do
    nombre "MyString"
    ficha 1
    representante_text "MyString"
    capital_text "MyString"
    capital "MyString"
    moneda "9.99"
    agente "MyString"
    notaria "MyString"
    fecha_registro "2013-10-14"
    status "MyString"
    duracion "MyString"
    provincia "MyString"
  end
end
