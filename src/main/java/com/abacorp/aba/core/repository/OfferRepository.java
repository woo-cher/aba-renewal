package com.abacorp.aba.core.repository;

import com.abacorp.aba.model.offer.Offer;
import com.abacorp.aba.model.offer.OfferAddition;
import com.abacorp.aba.model.offer.OfferAddress;
import com.abacorp.aba.model.dto.MapFiltersDto;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class OfferRepository {

    @Autowired
    @Qualifier("sqlSessionTemplate")
    private SqlSessionTemplate sqlSession;

    public Offer selectOfferById(int id) {
        return sqlSession.selectOne("selectOfferById", id);
    }

    // ───────────────────────── For `map.jsp` ───────────────────────── //
    public List<Offer> selectOffersInRectUsingFilter(MapFiltersDto dto) {
        return sqlSession.selectList("selectOffersInRectByFilters", dto);
    }

    public List<Offer> selectOffersByBelongsTo(MapFiltersDto dto) {
        return sqlSession.selectList("selectOffersByRegion", dto);
    }

    public List<Offer> selectOffersByLatLng(MapFiltersDto latLng) {
        return sqlSession.selectList("selectOffersByLatLng", latLng);
    }

    public List<Offer> selectOffersByIdKeyword(String idKey) {
        return sqlSession.selectList("selectOffersByIdKey", idKey);
    }

    public int selectCountByFilters(MapFiltersDto dto) {
        return sqlSession.selectOne("selectCountByBelongsAndFilters", dto);
    }
    // ───────────────────────────────────────────────────────────────── //

    /**
     * Insert `offer` and return `offerId` of inserted `offer`.
     *
     * @param offer
     * @return offerId (autogeneratedKey)
     */
    public int insertOffer(Offer offer) {
        return sqlSession.insert("insertOffer", offer);
    }

    /* return query row */
    public int insertOfferAddress(OfferAddress offerAddress) {
        return sqlSession.insert("insertOfferAddress", offerAddress);
    }

    /* return query row */
    public int insertOfferAddition(OfferAddition offerAddition) {
        return sqlSession.insert("insertOfferAddition", offerAddition);
    }

    public int deleteOfferById(int offerId) {
        return sqlSession.delete("deleteOfferById", offerId);
    }

    public int updateOfferThumbnailById(Offer offer) {
        return sqlSession.update("updateThumbnailById", offer);
    }

    public List<Offer> selectOffersByUserId(String userId) {
        return sqlSession.selectList("selectOffersByUserId", userId);
    }

    public int updateOffer(Offer offer) {
        return sqlSession.update("updateOffer", offer);
    }

    public int updateOfferAddress(OfferAddress offerAddress) {
        return sqlSession.update("updateOfferAddress", offerAddress);
    }

    public int updateOfferAddition(OfferAddition offerAddition) {
        return sqlSession.update("updateOfferAddition", offerAddition);
    }

    public String selectOfferThumbnail(int offerId) {
        return sqlSession.selectOne("selectOfferThumbnail", offerId);
    }

    public List<Offer> selectOffers() {
        return sqlSession.selectList("selectOffers");
    }

    public List<Offer> selectOffersByKeyword(String keyword) {
        return sqlSession.selectList("selectOffersByKeyword", keyword);
    }

    public List<Offer> selectOffersByFilter(MapFiltersDto dto) {
        return sqlSession.selectList("selectOffersByFilter", dto);
    }

    public int updateOfferStatusById(Map<String, Object> id) {
        return sqlSession.update("updateOfferStatusById", id);
    }
}
