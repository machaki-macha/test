public abstract with sharing class TestSubClass extends TestSuperClass {
    
    private Integer i3;
    private Integer i4;
    protected Integer num;

    public void calc2(Integer i3, Integer i4){
        //super.calc1(i1, i2);
        System.debug('calc2');
        this.i3 = i3;
        this.i4 = i4;
        System.debug('i1 * i2 = ' + (this.i1 * this.i2));
        System.debug('i3 - i4 = ' + (this.i3 - this.i4));
        System.debug('i3 / i4 = ' + (this.i3 / (double)this.i4));
    }

    public void succession2(Integer num){
        
        System.debug('継承2');
        this.num = num;
        System.debug('サブクラスです。');
        System.debug('継承2つ目の処理です。' + num);
    }

    public override Integer abstractTest(){
        System.debug('オーバライドです。');

        num = 100;
        return num;
    }

}