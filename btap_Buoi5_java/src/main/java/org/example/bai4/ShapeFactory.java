package org.example.bai4;

public class ShapeFactory {
    public static Shape getShape(String type) throws IllegalAccessException {
        if(type == null)return null;
        switch (type.toLowerCase()){
            case "circle":
                return new Circle();
            case "sqare":
                return new Square();
            default:
                throw new IllegalAccessException("Loai hinh khong hop le! "+type);
        }

    }
}
