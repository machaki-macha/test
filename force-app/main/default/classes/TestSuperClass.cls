public abstract with sharing class TestSuperClass {

    protected Integer i1;
    protected Integer i2;
    protected Integer num;
    
    public void calc1(Integer i1, Integer i2){
        System.debug('calc1');
        this.i1 = i1;
        this.i2 = i2;
        System.debug('i1 + i2 = '+ (this.i1 + this.i2));
    }
    public abstract Integer abstractTest();

    public void succession1(Integer num){
        System.debug('継承1');
        this.num = abstractTest();
        System.debug('スーパークラスです。');
        System.debug('継承1つ目の処理です。' + abstractTest());
    }
}