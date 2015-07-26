<?php
/**
 * @link https://github.com/old-town/old-town-workflow
 * @author  Malofeykin Andrey  <and-rey2@yandex.ru>
 */
namespace OldTown\Workflow\Test\Behat\Bootstrap;

use Behat\Behat\Context\Context;
use Behat\Behat\Context\SnippetAcceptingContext;
use OldTown\Workflow\Loader\AbstractDescriptor;
use Behat\Gherkin\Node\PyStringNode;
use Behat\Behat\Hook\Scope\BeforeScenarioScope;
use Behat\Gherkin\Node\ScenarioInterface;
use Behat\Behat\Hook\Scope\AfterStepScope;
use Behat\Behat\Tester\Result\ExecutedStepResult;
use Behat\Gherkin\Node\TableNode;
use OldTown\Workflow\Loader\WriteXmlInterface;
use PHPUnit_Framework_Assert;
use DOMElement;
use RuntimeException;


/**
 * Defines application features from the specific context.
 */
class WorkflowDescriptorContext implements Context, SnippetAcceptingContext
{
    /**
     *
     * @var string
     */
    protected $workflowDescriptorNamespace = 'OldTown\Workflow\Loader';

    /**
     * Последний созданный дескриптор
     *
     * @var AbstractDescriptor
     */
    protected $lastCreatedDescriptor;

    /**
     * @var
     */
    protected $currentScenario;

    /**
     * @Given Create descriptor :nameDescriptor
     * @param $nameDescriptor
     * @return AbstractDescriptor
     */
    public function createDescriptor($nameDescriptor)
    {
        try {
            $descriptor = $this->factoryDescriptor($nameDescriptor);
            return $descriptor;
        } catch (\Exception $e) {
            throw new \RuntimeException($e->getMessage(), $e->getCode(), $e);
        }
    }


    /**
     * @Given Create descriptor :nameDescriptor based on xml:
     *
     * @param string       $nameDescriptor
     * @param PyStringNode $xml
     *
     * @return AbstractDescriptor
     * @throws \RuntimeException
     */
    public function createDescriptorByNameBasedOnXml($nameDescriptor, PyStringNode $xml)
    {
        $useXmlErrors = libxml_use_internal_errors();
        try {
            libxml_use_internal_errors(true);
            libxml_clear_errors();

            $xmlDoc = new \DOMDocument();
            $xmlDoc->loadXML($xml->getRaw());

            $libxmlGetLastError = libxml_get_last_error();
            if ($libxmlGetLastError instanceof \LibXMLError) {
                throw new \RuntimeException($libxmlGetLastError->message, $libxmlGetLastError->code);
            }

            $descriptor = $this->factoryDescriptor($nameDescriptor, $xmlDoc->firstChild);

            libxml_use_internal_errors($useXmlErrors);
            return $descriptor;
        } catch (\Exception $e) {
            libxml_clear_errors();
            libxml_use_internal_errors($useXmlErrors);
            throw new \RuntimeException($e->getMessage(), $e->getCode(), $e);
        }
    }

    /**
     * @Then Call a method descriptor :nameMethod, I get the value of :expectedResult
     *
     * @param $nameMethod
     * @param $expectedResult
     *
     * @throws \RuntimeException
     */
    public function callAMethodDescriptorIGetTheValueOf($nameMethod, $expectedResult)
    {
        try {
            $descriptor = $this->getLastCreatedDescriptor();
            $r = new \ReflectionObject($descriptor);

            if (!$r->hasMethod($nameMethod)) {
                $errMsg = "Method {$nameMethod}  does not exist";
                throw new \InvalidArgumentException($errMsg);
            }

            $actualValue = $r->getMethod($nameMethod)->invoke($descriptor);

            $errMsg = sprintf(
                "Bug with attribute of \"variable-name\". Expected value: %s. Actual value: %s",
                $expectedResult,
                $actualValue
            );

            PHPUnit_Framework_Assert::assertEquals($expectedResult, $actualValue, $errMsg);
        } catch (\Exception $e) {
            throw new \RuntimeException($e->getMessage(), $e->getCode(), $e);
        }
    }

    /**
     * @When Call a method descriptor :nameMethod. The arguments of the method:
     * @param $nameMethod
     * @param TableNode $table
     */
    public function callAMethodDescriptorTheArgumentsOfTheMethod($nameMethod, TableNode $table)
    {
        try {
            $descriptor = $this->getLastCreatedDescriptor();
            $r = new \ReflectionObject($descriptor);

            if (!$r->hasMethod($nameMethod)) {
                $errMsg = "Method {$nameMethod}  does not exist";
                throw new \InvalidArgumentException($errMsg);
            }

            $rows = $table->getHash();
            if (1 !== count($rows)) {
                $errMsg = 'Incorrect arguments';
                throw new \InvalidArgumentException($errMsg);
            }

            $args = $rows[0];

            $r->getMethod($nameMethod)->invokeArgs($descriptor, $args);
        } catch (\Exception $e) {
            throw new \RuntimeException($e->getMessage(), $e->getCode(), $e);
        }
    }


    /**
     * @Then Call a method descriptor :nameMethod. I expect to get an exception :expectedException
     * @param string $nameMethod
     * @param string $expectedException
     */
    public function callAMethodDescriptorIExpectToGetAnException($nameMethod, $expectedException)
    {
        $actualException = null;
        try {
            $descriptor = $this->getLastCreatedDescriptor();
            $r = new \ReflectionObject($descriptor);

            if (!$r->hasMethod($nameMethod)) {
                $errMsg = "Method {$nameMethod}  does not exist";
                throw new \InvalidArgumentException($errMsg);
            }

            $r->getMethod($nameMethod)->invoke($descriptor);
        } catch (\Exception $e) {
            $actualException = $e;
        }

        PHPUnit_Framework_Assert::assertInstanceOf($expectedException, $actualException);
    }

    /**
     * @Then Call a method descriptor :nameMethod, I get the value of :expectedResult. The arguments of the method:
     *
     * @param string    $nameMethod
     * @param string    $expectedResult
     * @param TableNode $table
     *
     */
    public function callAMethodDescriptorIGetTheValueOfTheArgumentsOfTheMethod($nameMethod, $expectedResult, TableNode $table)
    {
        try {
            $descriptor = $this->getLastCreatedDescriptor();
            $r = new \ReflectionObject($descriptor);

            if (!$r->hasMethod($nameMethod)) {
                $errMsg = "Method {$nameMethod}  does not exist";
                throw new \InvalidArgumentException($errMsg);
            }

            $rows = $table->getHash();
            if (1 !== count($rows)) {
                $errMsg = 'Incorrect arguments';
                throw new \InvalidArgumentException($errMsg);
            }

            $args = $rows[0];

            $actualValue = $r->getMethod($nameMethod)->invokeArgs($descriptor, $args);

            $errMsg = sprintf(
                "Bug with attribute of \"variable-name\". Expected value: %s. Actual value: %s",
                $expectedResult,
                $actualValue
            );

            PHPUnit_Framework_Assert::assertEquals($expectedResult, $actualValue, $errMsg);
        } catch (\Exception $e) {
            throw new \RuntimeException($e->getMessage(), $e->getCode(), $e);
        }
    }

    /**
     * @Then I save to descriptor xml. Compare with xml:
     * @param PyStringNode $expectedXml
     */
    public function iSaveToDescriptorXmlCompareWithXml(PyStringNode $expectedXml)
    {
        try {
            $dom = new \DOMDocument();
            $dom->encoding = 'UTF-8';
            $dom->xmlVersion = '1.0';
            $dom->formatOutput = true;

            $descriptor = $this->getLastCreatedDescriptor();
            if (!$descriptor instanceof WriteXmlInterface) {
                $errMsg = 'Descriptor not implement WriteXmlInterface';
                throw new \RuntimeException($errMsg);
            }

            $result = $descriptor->writeXml($dom);

            if ($result instanceof \DOMDocument) {
                $actualXml = $result->saveXML();
            } elseif ($result instanceof \DOMElement) {
                $actualXml = $result->ownerDocument->saveXML($result);
            } else {
                $errMsg = 'Incorrect result writeXml';
                throw new \RuntimeException($errMsg);
            }
            $expectedXml = $expectedXml->getRaw();


            PHPUnit_Framework_Assert::assertXmlStringEqualsXmlString($expectedXml, $actualXml);
        } catch (\Exception $e) {
            throw new \RuntimeException($e->getMessage(), $e->getCode(), $e);
        }
    }

    /**
     * @Then I save to descriptor xml. I expect to get an exception :expectedException
     * @param string $expectedException
     */
    public function iSaveToDescriptorXmlIExpectToGetAnException($expectedException)
    {
        $actualException = null;
        try {
            $dom = new \DOMDocument();
            $dom->encoding = 'UTF-8';
            $dom->xmlVersion = '1.0';
            $dom->formatOutput = true;

            $descriptor = $this->getLastCreatedDescriptor();
            if (!$descriptor instanceof WriteXmlInterface) {
                $errMsg = 'Descriptor not implement WriteXmlInterface';
                throw new \RuntimeException($errMsg);
            }

            $descriptor->writeXml($dom);
        } catch (\Exception $e) {
            $actualException = $e;
        }

        PHPUnit_Framework_Assert::assertInstanceOf($expectedException, $actualException);
    }


    /**
     * @BeforeScenario @workflowDescriptor
     */
    public function beforeScenarioWithTagWorkflowDescriptor()
    {
        $this->lastCreatedDescriptor = null;
    }

    /**
     * @AfterStep
     *
     * @param AfterStepScope $scope
     */
    public function afterStepWithTagWorkflowDescriptor(AfterStepScope $scope)
    {
        if ($this->currentScenario instanceof ScenarioInterface && $this->currentScenario->hasTag('workflowDescriptor')) {
            $result = $scope->getTestResult();
            if ($result instanceof ExecutedStepResult) {
                $descriptor = $result->getCallResult()->getReturn();
                if ($descriptor instanceof AbstractDescriptor) {
                    $this->lastCreatedDescriptor = $descriptor;
                }
            }
        }
    }

    /**
     * Возвращает последний созданный дескриптор
     *
     * @return AbstractDescriptor
     *
     * @throws \RuntimeException
     */
    protected function getLastCreatedDescriptor()
    {
        if (!$this->lastCreatedDescriptor instanceof AbstractDescriptor) {
            $errMsg = 'Descriptor does not exist';
            throw new \RuntimeException($errMsg);
        }
        return $this->lastCreatedDescriptor ;
    }



    /**
     * @BeforeScenario
     * @param BeforeScenarioScope $scope
     */
    public function beforeScenario(BeforeScenarioScope $scope)
    {
        $this->currentScenario = $scope->getScenario();
    }


    /**
     * @AfterScenario
     */
    public function afterScenario()
    {
        $this->currentScenario = null;
    }

    /**
     * Наймспейс в котором находятся дескрипторы Workflow
     *
     * @return string
     */
    public function getWorkflowDescriptorNamespace()
    {
        return $this->workflowDescriptorNamespace;
    }

    /**
     * Фабрика по созданию дескрипторов
     *
     * @param string     $name
     *
     * @param DOMElement $element
     *
     * @return AbstractDescriptor
     * @throws RuntimeException
     */
    protected function factoryDescriptor($name, DOMElement $element = null)
    {
        $ns = $this->getWorkflowDescriptorNamespace();
        $class = "{$ns}\\{$name}";

        if (!class_exists($class)) {
            $errMsg = "Class not found {$class}";
            throw new \RuntimeException($errMsg);
        }

        $r = new \ReflectionClass($class);
        if (null === $element) {
            $descriptor = $r->newInstance();
        } else {
            $descriptor = $r->newInstanceArgs([
                $element
            ]);
        }

        if (!$descriptor instanceof AbstractDescriptor) {
            $errMsg = 'Descriptor not instance of AbstractDescriptor';
            throw new \RuntimeException($errMsg);
        }

        return $descriptor;
    }
}