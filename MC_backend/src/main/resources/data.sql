
insert into test(test_id, test_question)
values(1, "성함을 말씀해주세요.");

insert into test(test_id, test_question)
values(2, "오늘이 몇 월 며칠인지 말씀해주세요.");

insert into test(test_id, test_question)
values(3, "지금 계신 이 장소는 어떤 곳인가요?");

insert into test(test_id, test_question)
values(4, "지금 생각 나는 물건 3가지를 말씀해주세요.");

insert into test(test_id, test_question)
values(5, "이번 문제는 계산 문제입니다. '100 - 7' 계산 결과는 무엇일까요?");

insert into test(test_id, test_question)
values(6, "길에서 남의 주민등록증을 주웠다고 했을 때, 어떻게 하면 주인에게 찾아줄 수 있을까요?");

insert into test(test_id, test_question)
values(7, "5각형을 손으로 그려주세요.");

insert into test(test_id, test_question)
values(8, "4번 문항에서 답변했던 물건 3가지를 다시 말씀해주세요.");

insert into member(member_id, member_name, member_age, member_gender, created_at)
values(1, '이찬호', 26, '남', now());

insert into member(member_id, member_name, member_age, member_gender, created_at)
values(2, '김다빈', 25, '여', now());

insert into member(member_id, member_name, member_age, member_gender, created_at)
values(3, '이성호', 25, '남', now());

insert into member(member_id, member_name, member_age, member_gender, created_at)
values(4, '전두이', 24, '여', now());

insert into member(member_id, member_name, member_age, member_gender, created_at)
values(5, '고우라', 24, '여', now());

insert into place(place_id, place_name, place_location, place_latitude, place_longitude)
values(1, '주사랑노인복지센터', '강원 춘천시 동내면 세실로 62-3', 37.863259047992344, 127.75942706748984);

insert into place(place_id, place_name, place_location, place_latitude, place_longitude)
values(2, '천수노인복지센터', '강원 춘천시 두하길 22', 37.87617086082469, 127.74152747982255);

insert into place(place_id, place_name, place_location, place_latitude, place_longitude)
values(3, '춘천효사랑요양원', '강원 춘천시 춘천로 306-5', 37.881310923076924, 127.74718567872758);


