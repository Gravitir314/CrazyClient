// Decompiled by AS3 Sorcerer 5.64
// www.as3sorcerer.com

//kabam.rotmg.account.securityQuestions.commands.SaveSecurityQuestionsCommand

package kabam.rotmg.account.securityQuestions.commands{
    import kabam.rotmg.account.securityQuestions.tasks.SaveSecurityQuestionsTask;
    import kabam.lib.tasks.TaskMonitor;
    import kabam.rotmg.core.signals.TaskErrorSignal;
    import kabam.rotmg.dialogs.control.CloseDialogsSignal;
    import kabam.rotmg.core.signals.TrackEventSignal;
    import kabam.rotmg.account.securityQuestions.data.SecurityQuestionsModel;
    import kabam.lib.tasks.BranchingTask;
    import kabam.lib.tasks.TaskSequence;
    import kabam.lib.tasks.DispatchSignalTask;
    import kabam.lib.tasks.Task;
    import kabam.rotmg.core.service.TrackingData;

    public class SaveSecurityQuestionsCommand {

        [Inject]
        public var task:SaveSecurityQuestionsTask;
        [Inject]
        public var monitor:TaskMonitor;
        [Inject]
        public var taskError:TaskErrorSignal;
        [Inject]
        public var closeDialogs:CloseDialogsSignal;
        [Inject]
        public var track:TrackEventSignal;
        [Inject]
        public var securityQuestionsModel:SecurityQuestionsModel;


        public function execute():void{
            var _local_1:BranchingTask = new BranchingTask(this.task, this.makeSuccess(), this.makeFailure());
            this.monitor.add(_local_1);
            _local_1.start();
        }

        private function makeSuccess():Task{
            var _local_1:TaskSequence = new TaskSequence();
            _local_1.add(new DispatchSignalTask(this.track, this.getTrackingData()));
            _local_1.add(new DispatchSignalTask(this.closeDialogs));
            this.securityQuestionsModel.showSecurityQuestionsOnStartup = false;
            return (_local_1);
        }

        private function makeFailure():DispatchSignalTask{
            return (new DispatchSignalTask(this.taskError, this.task));
        }

        private function getTrackingData():TrackingData{
            var _local_1:TrackingData = new TrackingData();
            _local_1.category = "account";
            _local_1.action = "saveSecurityQuestions";
            return (_local_1);
        }


    }
}//package kabam.rotmg.account.securityQuestions.commands

