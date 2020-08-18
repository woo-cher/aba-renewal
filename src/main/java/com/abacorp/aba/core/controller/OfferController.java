package com.abacorp.aba.core.controller;


import com.abacorp.aba.core.service.MapService;
import com.abacorp.aba.model.Offer;
import com.abacorp.aba.model.type.OfferType;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/offers")
@Slf4j
public class OfferController {

    @Autowired
    private ModelAndView mv;

    @Autowired
    private MapService service;

    @RequestMapping("/{id}")
    public ModelAndView show(@PathVariable int id) {
        Offer offer = service.getOfferById(id);

        mv.setViewName("/offer/detail");
        mv.addObject("offer", offer);

        return mv;
    }

    // 관리자가 아니면, 매물 등록이 안되므로 차후 /admin/** 로 옮겨야 한다.
    @RequestMapping("/create")
    public ModelAndView create() {
        mv.setViewName("/admin/offer_create");
        mv.addObject("offerTypes", OfferType.values());

        return mv;
    }
}
