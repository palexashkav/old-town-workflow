Feature:Workflow Descriptor

@workflowDescriptor
Scenario: Create a descriptor from xml. Validate save in xml descriptor
Given Create descriptor "WorkflowDescriptor" based on xml:
"""
      <workflow>
        <meta name="lastModified">Sun Dec 17 16:57:01 ART 2006</meta>
        <meta name="created">Sun Dec 17 16:55:59 ART 2006</meta>
        <meta name="generator">OSWOrkflow Designer</meta>

        <registers>
          <register type="class" variable-name="log" id="10">
              <arg name="class.name">\OldTown\Workflow\Util\LogRegister</arg>
              <arg name="addInstanceId">true</arg>
          </register>
          <register type="phpshell" variable-name="value10" id="20">
            <arg name="script">echo 'test10';</arg>
          </register>
        </registers>

        <trigger-functions>
          <trigger-function id="30">
            <function type="class" id="40" name="value20">
              <arg name="class.name">value30</arg>
              <arg name="testArg">value40</arg>
            </function>
          </trigger-function>
          <trigger-function id="50">
            <function type="phpshell" id="60" name="value50">
              <arg name="script">echo 'test20';</arg>
            </function>
          </trigger-function>
          <trigger-function id="70">
            <function type="class" id="80" name="value60">
              <arg name="class.name">value70</arg>
              <arg name="testArg">value80</arg>
            </function>
          </trigger-function>
        </trigger-functions>

        <global-conditions>
          <conditions type="OR">

            <conditions type="AND">
              <condition type="phpshell" id="90" name="value90">
                  <arg name="script"><![CDATA[echo 'test30';]]></arg>
              </condition>
              <condition type="class" id="100" name="test-name"  negate="true">
                  <arg name="class.name">value100</arg>
                  <arg name="testArg">value110</arg>
              </condition>
            </conditions>
            <conditions type="OR">
              <condition type="phpshell" id="110" name="value120">
                  <arg name="script"><![CDATA[echo 'test50';]]></arg>
              </condition>
              <condition type="phpshell" id="120" name="130">
                  <arg name="script"><![CDATA[echo 'test60';]]></arg>
              </condition>
            </conditions>

          </conditions>
        </global-conditions>


        <initial-actions>
          <action id="150" name="Start Workflow">
            <results>
              <unconditional-result old-status="Finished" status="Underway" step="190" />
            </results>
          </action>
          <action id="160" name="Start Workflow - version2">
            <results>
              <unconditional-result old-status="Finished" status="Underway" step="190" />
            </results>
          </action>
        </initial-actions>

      <global-actions>
          <action id="153" name="test-global-actions-1">
            <results>
              <unconditional-result old-status="Finished" status="Underway" step="190" />
            </results>
          </action>
          <action id="157" name="test-global-actions-2">
            <results>
              <unconditional-result old-status="Finished" status="Underway" step="190" />
            </results>
          </action>
      </global-actions>


        <common-actions>
          <action id="170" name="common-action-1">
            <results>
              <unconditional-result old-status="Finished" status="Underway" step="200" />
            </results>
          </action>
          <action id="180" name="common-action-2">
            <results>
              <unconditional-result old-status="Finished" status="Underway" step="200" />
            </results>
          </action>
        </common-actions>


        <steps>
          <step id="190" name="step-1">
            <actions>
              <common-action id="180"/>
            </actions>
          </step>
          <step id="200" name="step-2">
            <actions>
              <common-action id="170"/>
              <action id="210" name="test-split-action">
                <results>
                  <unconditional-result old-status="Finished" split="2"/>
                </results>
              </action>
            </actions>
          </step>
          <step id="220" name="step-3">
            <actions>
              <action id="230" name="test-join-action-1">
                <results>
                  <unconditional-result old-status="Finished" join="280"/>
                </results>
              </action>
            </actions>
          </step>
          <step id="240" name="step-4">
            <actions>
              <action id="250" name="test-join-action-2">
                <results>
                  <unconditional-result old-status="Finished" join="280"/>
                </results>
              </action>
            </actions>
          </step>
          <step id="260" name="step-5">
            <actions>
              <action id="270" name="finish-action" >
                <results>
                  <unconditional-result old-status="Finished" status="Finished" step="270"/>
                </results>
              </action>
            </actions>
          </step>

        </steps>

        <splits>
            <split id="280">
                <unconditional-result old-status="Finished" status="Underway"  step="220"/>
                <unconditional-result old-status="Finished" status="Underway" step="230"/>
            </split>
        </splits>

        <joins>
            <join id="290">
                <unconditional-result old-status="Finished" status="Underway"  step="260"/>
            </join>
        </joins>

      </workflow>
    """
  Then I save to descriptor xml. Compare with xml:
  """
      <workflow>
        <meta name="lastModified">Sun Dec 17 16:57:01 ART 2006</meta>
        <meta name="created">Sun Dec 17 16:55:59 ART 2006</meta>
        <meta name="generator">OSWOrkflow Designer</meta>

        <registers>
          <register type="class" variable-name="log" id="10">
              <arg name="class.name">\OldTown\Workflow\Util\LogRegister</arg>
              <arg name="addInstanceId">true</arg>
          </register>
          <register type="phpshell" variable-name="value10" id="20">
            <arg name="script">echo 'test10';</arg>
          </register>
        </registers>

        <trigger-functions>
          <trigger-function id="30">
            <function type="class" id="40" name="value20">
              <arg name="class.name">value30</arg>
              <arg name="testArg">value40</arg>
            </function>
          </trigger-function>
          <trigger-function id="50">
            <function type="phpshell" id="60" name="value50">
              <arg name="script">echo 'test20';</arg>
            </function>
          </trigger-function>
          <trigger-function id="70">
            <function type="class" id="80" name="value60">
              <arg name="class.name">value70</arg>
              <arg name="testArg">value80</arg>
            </function>
          </trigger-function>
        </trigger-functions>

        <global-conditions>
          <conditions type="OR">

            <conditions type="AND">
              <condition type="phpshell" id="90" name="value90">
                  <arg name="script"><![CDATA[echo 'test30';]]></arg>
              </condition>
              <condition type="class" id="100" name="test-name"  negate="true">
                  <arg name="class.name">value100</arg>
                  <arg name="testArg">value110</arg>
              </condition>
            </conditions>
            <conditions type="OR">
              <condition type="phpshell" id="110" name="value120">
                  <arg name="script"><![CDATA[echo 'test50';]]></arg>
              </condition>
              <condition type="phpshell" id="120" name="130">
                  <arg name="script"><![CDATA[echo 'test60';]]></arg>
              </condition>
            </conditions>

          </conditions>
        </global-conditions>


        <initial-actions>
          <action id="150" name="Start Workflow">
            <results>
              <unconditional-result old-status="Finished" status="Underway" step="190" />
            </results>
          </action>
          <action id="160" name="Start Workflow - version2">
            <results>
              <unconditional-result old-status="Finished" status="Underway" step="190" />
            </results>
          </action>
        </initial-actions>

      <global-actions>
          <action id="153" name="test-global-actions-1">
            <results>
              <unconditional-result old-status="Finished" status="Underway" step="190" />
            </results>
          </action>
          <action id="157" name="test-global-actions-2">
            <results>
              <unconditional-result old-status="Finished" status="Underway" step="190" />
            </results>
          </action>
      </global-actions>

        <common-actions>
          <action id="170" name="common-action-1">
            <results>
              <unconditional-result old-status="Finished" status="Underway" step="200" />
            </results>
          </action>
          <action id="180" name="common-action-2">
            <results>
              <unconditional-result old-status="Finished" status="Underway" step="200" />
            </results>
          </action>
        </common-actions>


        <steps>
          <step id="190" name="step-1">
            <actions>
              <common-action id="180"/>
            </actions>
          </step>
          <step id="200" name="step-2">
            <actions>
              <common-action id="170"/>
              <action id="210" name="test-split-action">
                <results>
                  <unconditional-result old-status="Finished" split="2"/>
                </results>
              </action>
            </actions>
          </step>
          <step id="220" name="step-3">
            <actions>
              <action id="230" name="test-join-action-1">
                <results>
                  <unconditional-result old-status="Finished" join="280"/>
                </results>
              </action>
            </actions>
          </step>
          <step id="240" name="step-4">
            <actions>
              <action id="250" name="test-join-action-2">
                <results>
                  <unconditional-result old-status="Finished" join="280"/>
                </results>
              </action>
            </actions>
          </step>
          <step id="260" name="step-5">
            <actions>
              <action id="270" name="finish-action" >
                <results>
                  <unconditional-result old-status="Finished" status="Finished" step="270"/>
                </results>
              </action>
            </actions>
          </step>

        </steps>

        <splits>
            <split id="280">
                <unconditional-result old-status="Finished" status="Underway"  step="220"/>
                <unconditional-result old-status="Finished" status="Underway" step="230"/>
            </split>
        </splits>

        <joins>
            <join id="290">
                <unconditional-result old-status="Finished" status="Underway"  step="260"/>
            </join>
        </joins>

      </workflow>
   """


  @workflowDescriptor
  Scenario: Create empty WorkflowDescriptor. Test writeXml
    Given Create descriptor "WorkflowDescriptor"
    Then I save to descriptor xml. Not DomDocument. Compare with xml:
    """
    <?xml version="1.0"?>
    <workflow>
      <initial-actions/>
      <steps/>
    </workflow>
    """


  @workflowDescriptor
  Scenario: Create WorkflowDescriptor. Test workflow name.
    Given Create descriptor "WorkflowDescriptor"
    When Call a method descriptor "setName". The arguments of the method:
      |workflowName|
      |test        |
    Then Call a method descriptor "getName", I get the value of "test"

  @workflowDescriptor
  Scenario: Create WorkflowDescriptor. Test getStep method. StepId is not numeric.
    Given Create descriptor "WorkflowDescriptor"
    When Call a method descriptor "getStep". I expect to get an exception message "Аргумент должен быть числом". The arguments of the method:
      |id|
      |test        |

  @workflowDescriptor
  Scenario: Create WorkflowDescriptor. Test getInitialAction method. ActionId is not numeric.
    Given Create descriptor "WorkflowDescriptor"
    When Call a method descriptor "getInitialAction". I expect to get an exception message "Аргумент должен быть числом". The arguments of the method:
      |id|
      |test        |


  @workflowDescriptor
  Scenario: Create WorkflowDescriptor. Test getJoin method. JoinId is not numeric.
    Given Create descriptor "WorkflowDescriptor"
    When Call a method descriptor "getJoin". I expect to get an exception message "Аргумент должен быть числом". The arguments of the method:
      |id|
      |test        |



  @workflowDescriptor
  Scenario: Create WorkflowDescriptor. Test getSplit method. SplitId is not numeric.
    Given Create descriptor "WorkflowDescriptor"
    When Call a method descriptor "getSplit". I expect to get an exception message "Аргумент должен быть числом". The arguments of the method:
      |id|
      |test        |


  @workflowDescriptor
  Scenario: Create WorkflowDescriptor. Test getTriggerFunction method. FunctionId is not numeric.
    Given Create descriptor "WorkflowDescriptor"
    When Call a method descriptor "getTriggerFunction". I expect to get an exception message "Аргумент должен быть числом". The arguments of the method:
      |id|
      |test        |


  @workflowDescriptor
  Scenario: Create a descriptor from xml. Invalid xml. Two actions with the same id
    Given Create descriptor "WorkflowDescriptor" based on xml. I expect exception with the text "Действие с id 150 уже существует". Xml source:
    """
      <workflow>
        <initial-actions>
          <action id="150" name="Start Workflow">
            <results>
              <unconditional-result old-status="Finished" status="Underway" step="190" />
            </results>
          </action>
          <action id="150" name="Start Workflow - version2">
            <results>
              <unconditional-result old-status="Finished" status="Underway" step="190" />
            </results>
          </action>
        </initial-actions>

        <steps>
          <step id="190" name="step-1">
            <actions>
              <common-action id="180"/>
            </actions>
          </step>
        </steps>

      </workflow>
    """


  @workflowDescriptor
  Scenario: Create a descriptor from xml. Test getStep method
    Given Create descriptor "WorkflowDescriptor" based on xml:
    """
      <workflow>
        <initial-actions>
          <action id="150" name="Start Workflow - version2">
            <results>
              <unconditional-result old-status="Finished" status="Underway" step="190" />
            </results>
          </action>
        </initial-actions>

        <steps>
          <step id="190" name="step-1">
            <actions>
              <action id="270" name="finish-action" >
                <results>
                  <unconditional-result old-status="Finished" status="Finished" step="190"/>
                </results>
              </action>
            </actions>
          </step>
        </steps>

      </workflow>
    """
    When Get the descriptor using the method of "getStep". The arguments of the method:
      |id|
      |190|
    Then Call a method descriptor "getName", I get the value of "step-1"



  @workflowDescriptor
  Scenario: Create a descriptor from xml. Test getAction method. Get action from step.
    Given Create descriptor "WorkflowDescriptor" based on xml:
    """
      <workflow>
        <initial-actions>
          <action id="150" name="Start Workflow - version2">
            <results>
              <unconditional-result old-status="Finished" status="Underway" step="190" />
            </results>
          </action>
        </initial-actions>

        <steps>
          <step id="190" name="step-1">
            <actions>
              <action id="270" name="finish-action" >
                <results>
                  <unconditional-result old-status="Finished" status="Finished" step="190"/>
                </results>
              </action>
            </actions>
          </step>
        </steps>

      </workflow>
    """
    When Get the descriptor using the method of "getAction". The arguments of the method:
      |id|
      |270|
    Then Call a method descriptor "getName", I get the value of "finish-action"



  @workflowDescriptor
  Scenario: Create a descriptor from xml. Test getAction method. Get action from common-actions.
    Given Create descriptor "WorkflowDescriptor" based on xml:
    """
      <workflow>
        <initial-actions>
          <action id="150" name="Start Workflow - version2">
            <results>
              <unconditional-result old-status="Finished" status="Underway" step="190" />
            </results>
          </action>
        </initial-actions>

        <global-actions>
            <action id="153" name="test-global-actions-1">
              <results>
                <unconditional-result old-status="Finished" status="Underway" step="190" />
              </results>
            </action>
            <action id="157" name="test-global-actions-2">
              <results>
                <unconditional-result old-status="Finished" status="Underway" step="190" />
              </results>
            </action>
        </global-actions>

        <steps>
          <step id="190" name="step-1">
            <actions>
              <action id="270" name="finish-action" >
                <results>
                  <unconditional-result old-status="Finished" status="Finished" step="190"/>
                </results>
              </action>
            </actions>
          </step>
        </steps>

      </workflow>
    """
    When Get the descriptor using the method of "getAction". The arguments of the method:
      |id|
      |153|
    Then Call a method descriptor "getName", I get the value of "test-global-actions-1"


  @workflowDescriptor
  Scenario: Create a descriptor from xml. Test getInitialAction method.
    Given Create descriptor "WorkflowDescriptor" based on xml:
    """
      <workflow>
        <initial-actions>
          <action id="150" name="Start Workflow - version2">
            <results>
              <unconditional-result old-status="Finished" status="Underway" step="190" />
            </results>
          </action>
        </initial-actions>

        <steps>
          <step id="190" name="step-1">
            <actions>
              <action id="270" name="finish-action" >
                <results>
                  <unconditional-result old-status="Finished" status="Finished" step="190"/>
                </results>
              </action>
            </actions>
          </step>
        </steps>

      </workflow>
    """
    When Get the descriptor using the method of "getInitialAction". The arguments of the method:
      |id|
      |150|
    Then Call a method descriptor "getName", I get the value of "Start Workflow - version2"


  @workflowDescriptor
  Scenario: Create WorkflowDescriptor. Test getInitialAction method. ActionId does not exist
    Given Create descriptor "WorkflowDescriptor"
    When Call a method descriptor "getInitialAction", I get the value of "(null)null". The arguments of the method:
      |id|
      |1|


  @workflowDescriptor
  Scenario: Create WorkflowDescriptor. Test getCommonAction method. ActionId does not exist
    Given Create descriptor "WorkflowDescriptor"
    When Call a method descriptor "getCommonAction", I get the value of "(null)null". The arguments of the method:
      |id|
      |1|


  @workflowDescriptor
  Scenario: Create a descriptor from xml. Test getJoin method.
    Given Create descriptor "WorkflowDescriptor" based on xml:
    """
      <workflow>
        <initial-actions>
          <action id="150" name="Start Workflow - version2">
            <results>
              <unconditional-result old-status="Finished" status="Underway" step="190" />
            </results>
          </action>
        </initial-actions>

        <steps>
          <step id="190" name="step-1">
            <actions>
              <action id="270" name="finish-action" >
                <results>
                  <unconditional-result old-status="Finished" status="Finished" step="190"/>
                </results>
              </action>
            </actions>
          </step>
        </steps>


        <joins>
            <join id="290">
                <unconditional-result old-status="Finished" status="Underway"  step="190"/>
            </join>
        </joins>

      </workflow>
    """
    When Get the descriptor using the method of "getJoin". The arguments of the method:
      |id|
      |290|
    Then Call a method descriptor "getId", I get the value of "290"



  @workflowDescriptor
  Scenario: Create a descriptor from xml. Test getSplit method.
    Given Create descriptor "WorkflowDescriptor" based on xml:
    """
      <workflow>
        <initial-actions>
          <action id="150" name="Start Workflow - version2">
            <results>
              <unconditional-result old-status="Finished" status="Underway" step="190" />
            </results>
          </action>
        </initial-actions>

        <steps>
          <step id="190" name="step-1">
            <actions>
              <action id="270" name="finish-action" >
                <results>
                  <unconditional-result old-status="Finished" status="Finished" step="190"/>
                </results>
              </action>
            </actions>
          </step>
        </steps>


        <splits>
            <split id="280">
                <unconditional-result old-status="Finished" status="Underway"  step="190"/>
            </split>
        </splits>

      </workflow>
    """
    When Get the descriptor using the method of "getSplit". The arguments of the method:
      |id|
      |280|
    Then Call a method descriptor "getId", I get the value of "280"



  @workflowDescriptor
  Scenario: Create a descriptor from xml. Invalid xml. Invalid id at triger-function
    Then Create descriptor "WorkflowDescriptor" based on xml. I expect exception with the text "Аргумент должен быть числом". Xml source:
    """
      <workflow>
        <initial-actions>
          <action id="150" name="Start Workflow">
            <results>
              <unconditional-result old-status="Finished" status="Underway" step="190" />
            </results>
          </action>
        </initial-actions>

        <trigger-functions>
          <trigger-function id="not-integer">
            <function type="class" id="40" name="value20">
              <arg name="class.name">value30</arg>
              <arg name="testArg">value40</arg>
            </function>
          </trigger-function>
        </trigger-functions>


        <steps>
          <step id="190" name="step-1">
            <actions>
              <common-action id="180"/>
            </actions>
          </step>
        </steps>

      </workflow>
    """


  @workflowDescriptor
  Scenario: Create a descriptor from xml. Test getTriggerFunction method.
    Given Create descriptor "WorkflowDescriptor" based on xml:
    """
      <workflow>
        <initial-actions>
          <action id="150" name="Start Workflow">
            <results>
              <unconditional-result old-status="Finished" status="Underway" step="190" />
            </results>
          </action>
        </initial-actions>

        <trigger-functions>
          <trigger-function id="300">
            <function type="class" id="40" name="test-trigger-function">
              <arg name="class.name">value30</arg>
              <arg name="testArg">value40</arg>
            </function>
          </trigger-function>
        </trigger-functions>


        <steps>
          <step id="190" name="step-1">
            <actions>
              <common-action id="180"/>
            </actions>
          </step>
        </steps>

      </workflow>
    """
    When Get the descriptor using the method of "getTriggerFunction". The arguments of the method:
      |id|
      |300|
    Then Call a method descriptor "getName", I get the value of "test-trigger-function"

  @workflowDescriptor
  Scenario: Create WorkflowDescriptor. Test getTriggerFunction method. FunctionId does not exist
    Given Create descriptor "WorkflowDescriptor"
    Then Call a method descriptor "getTriggerFunction". I expect to get an exception message "Не найдена trigger-function с id 7". The arguments of the method:
      |id|
      |7|


  @workflowDescriptor
  Scenario: Create a descriptor from xml. Invalid xml. Two join with the same id
    Then Create descriptor "WorkflowDescriptor" based on xml. I expect exception with the text "Объеденение с id 500 уже существует". Xml source:
    """
      <workflow>
        <initial-actions>
          <action id="150" name="Start Workflow">
            <results>
              <unconditional-result old-status="Finished" status="Underway" step="190" />
            </results>
          </action>
        </initial-actions>

        <steps>
          <step id="190" name="step-1">
            <actions>
              <common-action id="180"/>
            </actions>
          </step>
        </steps>

        <joins>
            <join id="500">
                <unconditional-result old-status="Finished" status="Underway"  step="190"/>
            </join>
            <join id="500">
                <unconditional-result old-status="Finished" status="Underway"  step="190"/>
            </join>
        </joins>

      </workflow>
    """


  @workflowDescriptor
  Scenario: Create a descriptor from xml. Invalid xml. Two split with the same id
    Then Create descriptor "WorkflowDescriptor" based on xml. I expect exception with the text "Ветвление с id 500 уже существует". Xml source:
    """
      <workflow>
        <initial-actions>
          <action id="150" name="Start Workflow">
            <results>
              <unconditional-result old-status="Finished" status="Underway" step="190" />
            </results>
          </action>
        </initial-actions>

        <steps>
          <step id="190" name="step-1">
            <actions>
              <common-action id="180"/>
            </actions>
          </step>
        </steps>

        <splits>
            <split id="500">
                <unconditional-result old-status="Finished" status="Underway"  step="190"/>
            </split>
            <split id="500">
                <unconditional-result old-status="Finished" status="Underway"  step="190"/>
            </split>
        </splits>

      </workflow>
    """



  @workflowDescriptor
  Scenario: Create a descriptor from xml. Invalid xml. Two split with the same id
    Then Create descriptor "WorkflowDescriptor" based on xml. I expect exception with the text "Шаг с id 190 уже существует". Xml source:
    """
      <workflow>
        <initial-actions>
          <action id="150" name="Start Workflow">
            <results>
              <unconditional-result old-status="Finished" status="Underway" step="190" />
            </results>
          </action>
        </initial-actions>

        <steps>
          <step id="190" name="step-1">
            <actions>
              <common-action id="180"/>
            </actions>
          </step>
          <step id="190" name="step-2">
            <actions>
              <common-action id="180"/>
            </actions>
          </step>
        </steps>

      </workflow>
    """


  @workflowDescriptor
  Scenario: Create empty WorkflowDescriptor. Test valdate. Xml not valid. Xml not verified dtd
    Given Create descriptor "WorkflowDescriptor" based on xml:
    """
    <?xml version="1.0"?>
    <workflow>
      <initial-actions/>
      <steps/>
    </workflow>
    """
    Then I validated descriptor. I expect to get an exception "OldTown\Workflow\Exception\InvalidDtdSchemaException"


  @workflowDescriptor
  Scenario: Create empty WorkflowDescriptor. Test valdate. Xml valid.
    Given Create descriptor "WorkflowDescriptor" based on xml:
    """
    <?xml version="1.0"?>
    <workflow>
      <initial-actions>
        <action id="150" name="Start Workflow">
          <results>
            <unconditional-result old-status="Finished" status="Underway" step="190" />
          </results>
        </action>
      </initial-actions>
      <common-actions>
        <action id="180" name="common-action-1">
          <results>
            <unconditional-result old-status="Finished" status="Underway" step="180" />
          </results>
        </action>
      </common-actions>
      <steps>
          <step id="190" name="step-1">
            <actions>
              <common-action id="180"/>
            </actions>
          </step>
      </steps>
    </workflow>
    """
    Then Call a method descriptor "validate", I get the value of "(null)null"



  @workflowDescriptor
  Scenario: Create empty WorkflowDescriptor. Test valdate. Xml not valid. Incorrect global-actions
    Given Create descriptor "WorkflowDescriptor" based on xml:
    """
    <?xml version="1.0"?>
    <workflow>
      <initial-actions>
        <action id="150" name="Start Workflow">
          <results>
            <unconditional-result old-status="Finished" status="Underway" step="190" />
          </results>
        </action>
      </initial-actions>
      <common-actions>
        <action id="27" name="common-action-1">
          <results>
            <unconditional-result old-status="Finished" status="Underway" step="180" />
          </results>
        </action>
      </common-actions>
      <global-actions>
        <action id="180" name="common-action-2">
          <results>
            <unconditional-result old-status="Finished" status="Underway" step="190" />
          </results>
        </action>
        <action id="400" name="common-action-3">
          <results>
            <unconditional-result old-status="Finished" status="Underway" step="190" />
          </results>
        </action>
      </global-actions>
      <steps>
          <step id="190" name="step-1">
            <actions>
              <common-action id="27"/>
            </actions>
          </step>
      </steps>
    </workflow>
    """
    When Get the descriptor using the method of "getAction". The arguments of the method:
      |id|
      |400|
    When Call a method descriptor "setId". The arguments of the method:
      |id|
      |180|
    When Get the descriptor using the method of "getParent"
    Then I validated descriptor. I expect to get an exception message "Ошибка валидация. Действие с id 180 уже существует"


  @workflowDescriptor
  Scenario: Create empty WorkflowDescriptor. Test valdate.  Incorrect actions
    Given Create descriptor "WorkflowDescriptor" based on xml:
    """
    <?xml version="1.0"?>
    <workflow>
      <initial-actions>
        <action id="150" name="Start Workflow">
          <results>
            <unconditional-result old-status="Finished" status="Underway" step="190" />
          </results>
        </action>
      </initial-actions>
      <common-actions>
        <action id="27" name="common-action-1">
          <results>
            <unconditional-result old-status="Finished" status="Underway" step="180" />
          </results>
        </action>
      </common-actions>
      <global-actions>
        <action id="180" name="common-action-2">
          <results>
            <unconditional-result old-status="Finished" status="Underway" step="190" />
          </results>
        </action>
        <action id="400" name="common-action-3">
          <results>
            <unconditional-result old-status="Finished" status="Underway" step="190" />
          </results>
        </action>
      </global-actions>
      <steps>
          <step id="190" name="step-1">
            <actions>
              <action id="500" name="action-test">
                <results>
                  <unconditional-result old-status="Finished" status="Underway" step="190" />
                </results>
              </action>
            </actions>
          </step>
      </steps>
    </workflow>
    """
    When Get the descriptor using the method of "getAction". The arguments of the method:
      |id|
      |500|
    When Call a method descriptor "setId". The arguments of the method:
      |id|
      |180|
    When Get the descriptor using the method of "getParent"
    And Get the descriptor using the method of "getParent"
    Then I validated descriptor. I expect to get an exception message "Действие с id 180 найденное у шага 190 является дубликатом"



  @workflowDescriptor
  Scenario: Create empty WorkflowDescriptor. Test valdate.  Incorrect commonт action
    Given Create descriptor "WorkflowDescriptor" based on xml:
    """
    <?xml version="1.0"?>
    <workflow>
      <initial-actions>
        <action id="150" name="Start Workflow">
          <results>
            <unconditional-result old-status="Finished" status="Underway" step="190" />
          </results>
        </action>
      </initial-actions>
      <common-actions>
        <action id="27" name="common-action-1">
          <results>
            <unconditional-result old-status="Finished" status="Underway" step="180" />
          </results>
        </action>
      </common-actions>
      <global-actions>
        <action id="180" name="common-action-2">
          <results>
            <unconditional-result old-status="Finished" status="Underway" step="190" />
          </results>
        </action>
        <action id="400" name="common-action-3">
          <results>
            <unconditional-result old-status="Finished" status="Underway" step="190" />
          </results>
        </action>
      </global-actions>
      <steps>
          <step id="190" name="step-1">
            <actions>
              <action id="500" name="action-test">
                <results>
                  <unconditional-result old-status="Finished" status="Underway" step="190" />
                </results>
              </action>
            </actions>
          </step>
      </steps>
    </workflow>
    """
    When Get the descriptor using the method of "getCommonAction". The arguments of the method:
      |id|
      |27|
    When Call a method descriptor "setId". The arguments of the method:
      |id|
      |180|
    When Get the descriptor using the method of "getParent"
    Then I validated descriptor. I expect to get an exception message "common-action  с id 180 является дубликатом"


  @workflowDescriptor
  Scenario: Create empty WorkflowDescriptor. Test removeAction.  Delete global-action
    Given Create descriptor "WorkflowDescriptor" based on xml:
    """
    <?xml version="1.0"?>
    <workflow>
      <initial-actions>
        <action id="150" name="Start Workflow">
          <results>
            <unconditional-result old-status="Finished" status="Underway" step="190" />
          </results>
        </action>
      </initial-actions>
      <common-actions>
        <action id="27" name="common-action-1">
          <results>
            <unconditional-result old-status="Finished" status="Underway" step="180" />
          </results>
        </action>
      </common-actions>
      <global-actions>
        <action id="180" name="common-action-2">
          <results>
            <unconditional-result old-status="Finished" status="Underway" step="190" />
          </results>
        </action>
        <action id="400" name="common-action-3">
          <results>
            <unconditional-result old-status="Finished" status="Underway" step="190" />
          </results>
        </action>
      </global-actions>
      <steps>
          <step id="190" name="step-1">
            <actions>
              <action id="500" name="action-test">
                <results>
                  <unconditional-result old-status="Finished" status="Underway" step="190" />
                </results>
              </action>
            </actions>
          </step>
      </steps>
    </workflow>
    """
    Then Call a method descriptor "removeActionActionById", I get the value of "(boolean)true". The arguments of the method:
      |id|
      |400|



  @workflowDescriptor
  Scenario: Create empty WorkflowDescriptor. Test removeAction.  Delete action
    Given Create descriptor "WorkflowDescriptor" based on xml:
    """
    <?xml version="1.0"?>
    <workflow>
      <initial-actions>
        <action id="150" name="Start Workflow">
          <results>
            <unconditional-result old-status="Finished" status="Underway" step="190" />
          </results>
        </action>
      </initial-actions>
      <common-actions>
        <action id="27" name="common-action-1">
          <results>
            <unconditional-result old-status="Finished" status="Underway" step="180" />
          </results>
        </action>
      </common-actions>
      <global-actions>
        <action id="180" name="common-action-2">
          <results>
            <unconditional-result old-status="Finished" status="Underway" step="190" />
          </results>
        </action>
        <action id="400" name="common-action-3">
          <results>
            <unconditional-result old-status="Finished" status="Underway" step="190" />
          </results>
        </action>
      </global-actions>
      <steps>
          <step id="190" name="step-1">
            <actions>
              <action id="500" name="action-test">
                <results>
                  <unconditional-result old-status="Finished" status="Underway" step="190" />
                </results>
              </action>
            </actions>
          </step>
      </steps>
    </workflow>
    """
    Then Call a method descriptor "removeActionActionById", I get the value of "(boolean)true". The arguments of the method:
      |id|
      |500|

