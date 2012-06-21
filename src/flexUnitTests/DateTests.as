package flexUnitTests
{
  
  import mx.collections.ArrayCollection;
  
  import org.flexunit.asserts.assertEquals;
  
  import views.MyCal;

  public class DateTests
  {		
    public var myCal:MyCal;
    public var testDayData:ArrayCollection;
    public var testDateFieldName:String = "dataDate";
    
    [Before]
    public function setUp():void
    {
      myCal = new MyCal();
      testDayData = new ArrayCollection([ {title:"my data title1", dataDate: new Date(2012,05,15)},
                                          {title:"my data title2", dataDate: new Date(2012,05,15)},
                                          {title:"my data title3", dataDate: new Date(2012,05,15)},
                                          {title:"my data title4", dataDate: new Date(2012,05,18)},
                                          {title:"my data title5", dataDate: new Date(2012,05,19)},
                                          {title:"my data title6", dataDate: new Date(2012,05,20)},
                                          {title:"my data title7", dataDate: new Date(2012,05,20)},
                                          {title:"my data title8", dataDate: new Date(2012,05,20)},
                                          {title:"my data title9", dataDate: new Date(2012,05,20)},
                                          {title:"my data title10", dataDate: new Date(2012,6,8)},
                                          {title:"my data title10", dataDate: new Date(2012,4,20)},
                                          {title:"my data title10", dataDate: new Date(2012,6,4)},
                                          {title:"my data title10", dataDate: new Date(2012,4,20)},
                                          {title:"my data title10", dataDate: new Date(2012,6,4)},
                                          {title:"my data title10", dataDate: new Date(2012,4,20)},
                                          {title:"my data title10", dataDate: new Date(2012,6,4)},
                                          {title:"my data title10", dataDate: new Date(2012,4,2)},
                                          {title:"my data title10", dataDate: new Date(2012,6,1)},
                                          {title:"my data title10", dataDate: new Date(2012,4,2)},
                                          {title:"my data title10", dataDate: new Date(2012,6,1)},
      
      ]);
    }
    
    [After]
    public function tearDown():void
    {
      myCal = null;
    }
    
    // this tests the first day of the month and the number of days in a month
    [Test]
    public function importantDatesTest():void {
      // june 15th 2012
      myCal.selectedDate = new Date(2012,05,15);
      myCal.setupImportantDates();
      assertEquals(myCal.firstDayOfWeek, 5);
      assertEquals(myCal.lastDayOfMonth, 30);
      
      // last day of june
      myCal.selectedDate = new Date(2012,06,0);
      myCal.setupImportantDates();
      assertEquals(myCal.firstDayOfWeek, 5);
      assertEquals(myCal.lastDayOfMonth, 30);
      
      // july 31st
      myCal.selectedDate = new Date(2012,06,31);
      myCal.setupImportantDates();
      assertEquals(myCal.firstDayOfWeek, 0);
      assertEquals(myCal.lastDayOfMonth, 31);
      
      //feb 2012 - a leap year
      myCal.selectedDate = new Date(2012,01,15);
      myCal.setupImportantDates();
      assertEquals(myCal.firstDayOfWeek, 3);
      assertEquals(myCal.lastDayOfMonth, 29);
      
      //feb 2012 - a leap year
      myCal.selectedDate = new Date(2011,01,15);
      myCal.setupImportantDates();
      assertEquals(myCal.firstDayOfWeek, 2);
      assertEquals(myCal.lastDayOfMonth, 28);
    }
    
    [Test]
    public function testNextMonth():void {
      myCal.selectedDate = new Date(2012,05,15);
      myCal.setupImportantDates();
      myCal.nextMonth();
      var myTempDate:Date = myCal.selectedDate;
      
      assertEquals(myCal.firstDayOfWeek, (new Date(myTempDate.fullYear,myTempDate.month,1).day));
      assertEquals(myCal.lastDayOfMonth, (new Date(myTempDate.fullYear,myTempDate.month+1,0)).date);
    }
    
    [Test]
    public function testDateIndexes():void {
      myCal.selectedDate = new Date(2012,05,0); 
      
      var tempDate:Date = myCal.selectedDate;
      myCal.buildCalendarReference();
      assertEquals(myCal.calIndex.getItemAt(myCal.firstDayOfWeek).date.date,(new Date(tempDate.fullYear,tempDate.month,1)).date);
      assertEquals(myCal.calIndex.getItemAt(myCal.lastDayOfMonth+myCal.firstDayOfWeek-1).date.date,(new Date(tempDate.fullYear,tempDate.month+1,0).date));
      
      // test for the next 30 years
      for(var i:int = 1; i <= 360; i++) {
        myCal.nextMonth();
        tempDate = myCal.selectedDate;
        myCal.buildCalendarReference();
        assertEquals(myCal.calIndex.getItemAt(myCal.firstDayOfWeek).date.date,(new Date(tempDate.fullYear,tempDate.month,1)).date);
        assertEquals(myCal.calIndex.getItemAt(myCal.lastDayOfMonth+myCal.firstDayOfWeek-1).date.date,(new Date(tempDate.fullYear,tempDate.month+1,0).date));
        trace(i + " | " + myCal.selectedDate.toString())
      }
      
      // test backwards 60 years
      for(var j:int = 360; j >= 1 ; j--) {
        myCal.prevMonth();
        tempDate = myCal.selectedDate;
        myCal.buildCalendarReference();
        assertEquals(myCal.calIndex.getItemAt(myCal.firstDayOfWeek).date.date,(new Date(tempDate.fullYear,tempDate.month,1)).date);
        assertEquals(myCal.calIndex.getItemAt(myCal.lastDayOfMonth+myCal.firstDayOfWeek-1).date.date,(new Date(tempDate.fullYear,tempDate.month+1,0).date));
        trace(j + " | " + myCal.selectedDate.toString())
      }
    }
    
    [Test]
    public function testPrepareData():void {
      myCal.calendarData = testDayData;
      myCal.dateFieldName = testDateFieldName;
      myCal.selectedDate = new Date(2012,05,15);
      myCal.buildCalendarReference();
      assertEquals(myCal.calDayDataHash["2012515"].length,3);
    }
  }
}