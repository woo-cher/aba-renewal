<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>회원가입</title>
    <link rel="icon" type="image/png" sizes="16x16" href="/img/favicon.ico">

    <link rel="stylesheet" type="text/css" href="/scss/component/form.css">

    <script src="/js/jquery-utils.js"></script>
    <script src="/js/kakao/kakao-address.js"></script>
    <script src="/js/kakao/ajax/ajax-repository.js"></script>

    <%@include file="/WEB-INF/jsp/commons/header.jspf"%>
</head>
<body>
<div class="main-container">
    <article class="content-wrap">
        <div class="content-name" id="top">
            <h3>
                <span class="aba">아바</span>
                <span class="header mini">회원가입</span>
            </h3>
        </div>

        <section class="form-control" id="agree-area">
            <ul class="checkbox-container p-0">
                <li class="absolute">
                    <input id="agree-all" type="checkbox" name="agree" value="" class="check">
                    <label for="agree-all" onclick="agreeAll()">
                        <span class="aba">'모든 약관'</span> 에 동의합니다.
                    </label>
                </li>
            </ul>
            <%-- Agree --%>
            <form id="agree-form">
            <c:forEach begin="0" end="3" varStatus="status">
                <div class="form-warp">
                    <div class="form-label">
                        <i class="fas fa-circle"></i>
                        <span>${keys[status.index]}</span>
                    </div>
                    <div class="form-category agree">
                        <c:import url="/WEB-INF/jsp/agree/${values[status.index]}.jsp" />
                    </div>
                    <ul class="checkbox-container agree">
                        <li>
                            <input id="agree${status.index}" type="checkbox" name="agree" value="" class="check">
                            <label for="agree${status.index}">
                                <span class="aba">'${keys[status.index]}'</span> 에 동의합니다.
                            </label>
                        </li>
                    </ul>
                </div>
            </c:forEach>
            </form>
            <button class="login-button" id="join" type="submit" onclick="agreeValidator()">가입하기</button>
        </section>

        <section class="form-control" id="register-area" hidden>
            <%-- Form --%>
            <form id="registerForm" action="/users/create" method="post" onsubmit="return submitValidator()">
                <div class="form-warp">
                    <div class="form-category">
                        <div class="form-label">
                            <span class="form-label mini">
                                <i class="fas fa-users"></i>
                                회원유형
                            </span>
                        </div>
                        <ul class="checkbox-container form type">
                            <li class="checkbox-list">
                                <input id="qq" type="radio" name="type" value="OWNER" class="check">
                                <label for="qq">집주인</label>
                            </li>
                            <li class="checkbox-list">
                                <input id="ww" type="radio" name="type" value="BROKER" class="check">
                                <label for="ww">공인중개사</label>
                            </li>
                            <li class="checkbox-list">
                                <input id="ee" type="radio" name="type" value="ASSISTANT" class="check">
                                <label for="ee">중개보조원</label>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="form-warp">
                    <div class="form-label">
                        <i class="fas fa-circle"></i>
                        <span>기본항목</span>
                    </div>
                    <div class="form-category">
                        <div class="input-group">
                            <input required autofocus type="text" id="userId" class="middle" placeholder="아이디" name="userId"
                                   pattern="^[A-Za-z][A-Za-z0-9]{1,12}"
                                   oninvalid="this.setCustomValidity(`공백, 특수문자 또는 한글이 포함되네요 :(`)"
                                   oninput="this.setCustomValidity(''); this.checkValidity()"
                                   onkeyup="userIdValidator($(this))"
                            >
                            <p class="icon" onclick="checkUserExist($(this).prev())"><i class="fas fa-user-check"></i></p>
                            <p class="aba m-auto check-user"></p>
                        </div>
                        <input required autofocus type="password" placeholder="비밀번호" id="password" name="password"
                               oninvalid="this.setCustomValidity(`비밀번호를 입력해주세요 :)`)"
                               oninput="this.setCustomValidity(''); this.checkValidity()"
                               onkeyup="passwordValidator()"
                        >
                        <input required autofocus type="password" placeholder="비밀번호 확인" id="cPassword"
                               oninvalid="this.setCustomValidity(`비밀번호를 입력해주세요 :)`)"
                               oninput="this.setCustomValidity(''); this.checkValidity()"
                               onkeyup="passwordValidator()"
                        >
                        <p class="aba m-auto check-password" hidden></p>
                        <input required autofocus type="text" placeholder="닉네임" name="nickName">
                    </div>
                </div>
                <div class="form-warp">
                    <div class="form-label">
                        <i class="fas fa-circle"></i>
                        <span>개인정보</span>
                    </div>
                    <div class="form-category">
                        <input required autofocus type="text" placeholder="이름" name="name">
                        <div class="input-group">
                            <input required autofocus type="text" class="middle" placeholder="이메일" name="email">
                            <p class="mail"><i class="fas fa-at"></i></p>
                            <select class="w-half" required name="email" onchange="watchSelect($(this))"
                                    oninvalid="this.setCustomValidity(`도메인을 선택해주세요 :)`)"
                                    oninput="this.setCustomValidity(''); this.checkValidity()"
                            >
                                <option value="">도메인</option>
                                <option value="naver.com">naver.com</option>
                                <option value="gmail.com">gmail.com</option>
                                <option value="daum.net">daum.net</option>
                                <option value="nate.com">nate.com</option>
                                <option id="self" value="">직접입력</option>
                            </select>
                        </div>
                        <input hidden disabled autofocus type="text" placeholder="도메인을 입력해주세요 :)" name="email"
                               pattern="^[a-z.]*"
                               oninvalid="this.setCustomValidity(`도메인을 입력해주세요 :)`)"
                               oninput="this.setCustomValidity(''); this.checkValidity()"
                               onkeyup="keywordConverter($(this))"
                        >
                        <div class="input-group">
                            <input required readonly autofocus type="text" class="short" placeholder="010" name="phone" value="010"
                                   pattern="^[0-9]{1,3}"
                                   oninvalid="this.setCustomValidity(`숫자를 입력해주세요 :)`)"
                                   oninput="this.setCustomValidity(''); this.checkValidity()"
                                   onkeyup="keywordConverter($(this))"
                            >
                            <p class="short">-</p>
                            <input required autofocus type="text" class="short" placeholder="####" name="phone"
                                   pattern="^[0-9]{4}"
                                   oninvalid="this.setCustomValidity(`4자리 숫자 입력해주세요 :)`)"
                                   oninput="this.setCustomValidity(''); this.checkValidity()"
                                   onkeyup="keywordConverter($(this), 'phone')"
                            >
                            <p class="short">-</p>
                            <input required autofocus type="text" class="short" placeholder="####" name="phone"
                                   pattern="^[0-9]{4}"
                                   oninvalid="this.setCustomValidity(`4자리 숫자 입력해주세요 :)`)"
                                   oninput="this.setCustomValidity(''); this.checkValidity()"
                                   onkeyup="keywordConverter($(this), 'phone')"
                            >
                        </div>
                        <div class="input-group">
                            <input autofocus readonly type="text" class="middle" id="jibun" placeholder="자택 주소" name="jibunAddr">
                            <input autofocus readonly type="text" class="middle" id="road" placeholder="도로명" name="roadAddr">
                            <p class="icon addr" onclick="getAddress()"><i class="fas fa-search"></i></p>
                        </div>
                        <div class="input-group">
                            <input autofocus type="text" class="large" id="extra" placeholder="아바아파트 3동 101호 or 아바빌 401호" name="extraAddr">
                            <input type="hidden" id="latitude" name="locationX">
                            <input type="hidden" id="longitude" name="locationY">
                        </div>

                        <p class="error" id="privateInfoError" hidden>
                            <i class="fas fa-exclamation-circle">
                                Error Message
                            </i>
                        </p>
                    </div>
                </div>
                <div class="form-warp">
                    <div class="form-label">
                        <i class="fas fa-circle"></i>
                        <span>추가정보</span>
                    </div>
                    <div class="form-category agent" hidden>
                        <input type="text" placeholder="중개업소 상호명" name="agentName"
                               pattern="^[가-힣A-Za-z0-9]*"
                               oninvalid="this.setCustomValidity(`공백 또는 특수문자가 포함되나 봅니다 :)`)"
                               oninput="this.setCustomValidity(''); this.checkValidity()"
                               onkeyup="keywordConverter($(this))"
                        >
                        <input type="text" placeholder="중개업소 대표자명" id="agentLeader" name="agentLeader" hidden
                               pattern="^[가-힣]*"
                               oninvalid="this.setCustomValidity(`공백 또는 특수문자가 포함되나 봅니다 :)`)"
                               oninput="this.setCustomValidity(''); this.checkValidity()"
                               onkeyup="keywordConverter($(this))"
                        >
                        <input type="text" placeholder="중개업소 등록번호" name="agentNumber"
                               pattern="^[가-힣0-9-]*"
                               oninvalid="this.setCustomValidity(`등록번호 형식에 맞지 않아요 :(`)"
                               oninput="this.setCustomValidity(''); this.checkValidity()"
                               onkeyup="keywordConverter($(this))"
                        >
                        <div class="input-group">
                            <input type="text" class="short" placeholder="사무실 연락처" name="agentPhone"
                                   pattern="^[0-9]{1,4}"
                                   oninvalid="this.setCustomValidity(`숫자를 입력해주세요 :)`)"
                                   oninput="this.setCustomValidity(''); this.checkValidity()"
                                   onkeyup="keywordConverter($(this))"
                            >
                            <p class="short">-</p>
                            <input type="text" class="short" placeholder="####" name="agentPhone"
                                   pattern="^[0-9]{4}"
                                   oninvalid="this.setCustomValidity(`4자리 숫자 입력해주세요 :)`)"
                                   oninput="this.setCustomValidity(''); this.checkValidity()"
                                   onkeyup="keywordConverter($(this), 'phone')"
                            >
                            <p class="short">-</p>
                            <input type="text" class="short" placeholder="####" name="agentPhone"
                                   pattern="^[0-9]{4}"
                                   oninvalid="this.setCustomValidity(`4자리 숫자 입력해주세요 :)`)"
                                   oninput="this.setCustomValidity(''); this.checkValidity()"
                                   onkeyup="keywordConverter($(this), 'phone')"
                            >
                        </div>
                    </div>
                    <div class="form-category">
                        <ul class="checkbox-container form">
                            <li class="checkbox-list">
                                <input id="1" type="checkbox" name="isEmailReception" value="" class="check">
                                <label for="1">이메일 수신 동의하기</label>
                            </li>
                            <li class="checkbox-list">
                                <input id="2" type="checkbox" name="isSmsReception" value="" class="check">
                                <label for="2">
                                    SMS 수신 동의하기
                                </label>
                            </li>
                            <li class="checkbox-list">
                                <input id="3" type="checkbox" name="isProfileOpen" value="" class="check">
                                <label for="3">
                                    프로필 공개 동의
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>
                <button class="login-button" type="submit">회원가입</button>
            </form>
        </section>
    </article>
</div>

<%-- footer --%>
<%@include file="/WEB-INF/jsp/commons/footer.jspf"%>
</body>
</html>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    let isCanUsingId = false;
    let isPassMatch = false;
    let isFindAddress = false;

    $(document).ready(() => {
        $('input[type="radio"]').click(function (e) {
            $('#userTypeError').remove();
            $('.agent').hide();

            const current = e.currentTarget;

            if(current.value === "BROKER" || current.value === "ASSISTANT") {
                $('.agent').show();

                $('.agent > input').attr("required", true);

                $('#jibun').attr("placeholder", "사무실 주소");
                $('#extra').attr("placeholder", "아바공인중개사");

                if(current.value === "ASSISTANT") {
                    $('#agentLeader').show();
                    $('#agentLeader').attr("required", true);
                } else {
                    $('#agentLeader').hide();
                    $('#agentLeader').attr("required", false);
                }
            } else {
                $('.agent > input').attr("required", false);

                $('#jibun').attr("placeholder", "자택 주소");
                $('#extra').attr("placeholder", "아바아파트 3동 101호 or 아바빌 401호");
            }
        });
    });

    // Agree
    function agreeAll() {
        let agrees = $('input[name="agree"]');
        let isChecked = $('#agree-all').prop("checked");

        isChecked === true ? agrees.prop("checked", false) : agrees.prop("checked", true);

        // '모든약관' 라벨 체크 인식이 안되는 현상 임시 조치
        $("#agree-all").click();
        isChecked = true;

        agrees.next().removeClass('invalid');
        $('.error.agree').remove();

        if(isChecked) {
            moveScroll($("#join").offset().top);
        }
    }

    function agreeValidator() {
        let selector;

        for(let i = 0; i < 4; i++) {
            selector = $('#agree' + i);

            selector.click(function() {
                selector.next().removeClass('invalid');
                selector.parent().siblings('.error').remove();
            });

            if( ! selector.is(':checked')) {
                moveScroll(selector.parent().offset().top - 15);

                if(!selector.next().hasClass('invalid')) {
                    selector.parents('ul')
                        .append(
                            '<p class="error agree">' +
                            '<i class="fas fa-exclamation-circle">' +
                            '</i> 항목에 동의해주세요 :)</p>'
                        );
                }

                selector.next().addClass('invalid b-1r');

                return
            }
        }

        $('#agree-area').hide();
        $("#register-area").show();

        moveScroll($("#top").offset().top);
    }

    // Sign up
    function checkUserExist(selector) {
        const errorArea = $('.check-user');
        const userId = selector.val();

        if(userId === '') {
            errorArea.text('ID를 입력해주세요 :)');
            errorArea.removeClass('invalid b-1r');
            return;
        }

        if(userIdValidator(selector).length < 4) {
            errorArea.text('최소 4자 이상입니다! :P');
            errorArea.addClass('invalid');
            isCanUsingId = false;
            return;
        }

        $.ajax({
            url: '/users/' + userId,
            type: 'GET',
            async: false,
            success: function (isExist) {
                if(isExist) {
                    isCanUsingId = false;
                    errorArea.text("사용 불가한 아이디예요 :(");
                    errorArea.addClass("invalid");
                    selector.addClass("invalid b-1r");
                } else {
                    isCanUsingId = true;
                    errorArea.text("사용 가능해요 :)");
                    errorArea.removeClass("invalid");
                    selector.removeClass("invalid b-1r");
                }
            },
            error: () => { alert('error') }
        })
    }

    function userIdValidator(focus) {
        let idRegex = new RegExp(focus.attr('pattern'));
        let result = idRegex.exec(focus.val());

        if(result === null) {
            $(focus).val('');
            console.log('1111111111111');
            return
        } else {
            if(result[0].length > 12) {
                console.log('222222222)');
                $('.check-user').text("최대 12자까지 가능해요 :)")
            }
        }
        console.log('3333333)', result[0]);
        $(focus).val(result);

        return result[0];
    }

    function keywordConverter(focus, mode) {
        let idRegex = new RegExp(focus.attr('pattern'));
        let result = idRegex.exec(focus.val());

        if(mode === 'phone') {
            if(focus.val().length > 3) {
                $(focus).val(result);
            }
        } else {
            $(focus).val(result);
        }
    }

    function passwordValidator() {
        const errorArea = $('.check-password');
        const focus = $('#cPassword');
        const clazz = "invalid b-1r";

        const matcher = focus.prev().val();
        const actual = focus.val();

        if(actual === '') {
            errorArea.hide();
        } else if(matcher === actual) {
            errorArea.removeClass('invalid');
            errorArea.text('비밀번호가 일치해요 :D');

            focus.removeClass(clazz);
            focus.prev().removeClass(clazz);

            isPassMatch = true;
        } else {
            errorArea.addClass('invalid');
            errorArea.text('두 비밀번호가 틀려요 :(');

            focus.addClass(clazz);
            focus.prev().addClass(clazz);

            isPassMatch = false;
        }

        errorArea.show();
    }

    function watchSelect(focus) {
        const selfDomainDom = focus.parent().next();

        if($('#self').prop('selected')) {
            focus.removeAttr('name');
            focus.attr('required', false);

            selfDomainDom.show();
            selfDomainDom.removeAttr("disabled");
            selfDomainDom.attr("required", true);
        } else {
            focus.attr('name', 'email');
            focus.attr('required', true);

            selfDomainDom.hide();
            selfDomainDom.removeAttr("required");
            selfDomainDom.attr("disabled", true);
        }
    }

    function submitValidator() {
        let userTypes = $('input[type="radio"]');
        let isSelectedUserType = false;

        // User type check
        for(let i = 0; i < userTypes.length; i++) {
            if($(userTypes[i]).prop("checked")) {
                isSelectedUserType = true;
            }
        }

        if(!isSelectedUserType) {
            const selector = $('.checkbox-container.type').parent();

            if(!selector.children().hasClass('error')) {
                selector.append(
                    '<p class="error" id="userTypeError">' +
                    '<i class="fas fa-exclamation-circle">' +
                    '</i> 회원 유형을 선택해주세요! :)</p>'
                );
            }

            moveScroll(selector.offset().top);

            return false;
        }

        // UserId check
        if(!isCanUsingId) {
            $('.check-user').text("중복을 확인해주세요! :)");
            moveScroll($("#userId").offset().top);

            return false;
        }

        // Is password passed?
        if(!isPassMatch) {
            moveScroll($("#password").offset().top);

            return false;
        }

        if(!isFindAddress) {
            $('#jibun').addClass('invalid b-1r');
            $('#road').addClass('invalid b-1r');
            $('#privateInfoError > i').text(' 주소를 검색해주세요!');
            $('#privateInfoError').show();

            moveScroll($("#jibun").offset().top);

            return false;
        }

        if($('#extra').val() === '') {
            $('#extra').addClass('invalid b-1r');
            $('#privateInfoError > i').text(' 상세주소를 입력해주세요!');
            $('#privateInfoError').show();

            moveScroll($("#extra").offset().top);

            return false;
        }

        return true;
    }
</script>
