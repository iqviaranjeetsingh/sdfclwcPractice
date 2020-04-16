trigger AcountTriggerForPractice on Account (before insert, before update, before delete,
                                            after insert, after update, after delete, after undelete) {
    SwitchCasePractice.switchOptionPractive(trigger.new, trigger.old, trigger.operationType);
}