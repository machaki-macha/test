public with sharing class TestSubClass2 extends TestSubClass {
    
    protected Integer num;

        public void succession3(Integer num){
            //super(3);
            super.succession1(1);
            TestSubClass SubClass = new TestSubClass();
            subclass.succession2(2);

            System.debug('継承3');
            this.num = num;
            System.debug('サブサブクラスです。');
            System.debug('継承3つ目の処理です。' + num);
        }
}