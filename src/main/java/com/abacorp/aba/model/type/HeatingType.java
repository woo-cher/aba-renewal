package com.abacorp.aba.model.type;

import com.abacorp.aba.model.mapper.TypeMapper;
import com.fasterxml.jackson.annotation.JsonFormat;

@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum HeatingType implements TypeMapper {

    UNKNOWN("UNKNOWN"),

    /**
     * 난방유형
     */
    GAS("도시가스"),
    LPG("LPG"),
    OIL("기름보일러"),
    ELECT("심야전기"),
    PANEL("판넬");

    private String value;

    HeatingType(String value) {
        this.value = value;
    }

    @Override
    public String getValue() {
        return value;
    }

    @Override
    public String getCode() {
        return name();
    }

    @Override
    public String toString() {
        return "HeatingType {" +
                "value='" + value + '\'' +
                '}';
    }
}
