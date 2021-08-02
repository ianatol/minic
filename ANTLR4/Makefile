# Should really move to something else to manage the build.

# Provided code assumes at least Java 8
JAVAC=javac
JAVA=java
ANTLRJAR=./antlr-4.8-complete.jar
JSONJAR=./javax.json-1.0.4.jar
SOURCEPATH=./src
BUILDPATH=./build

CLASSPATH_MOD=$(ANTLRJAR):$(JSONJAR)

VPATH=./src

FILES=MiniCompiler.java MiniToJsonVisitor.java MiniToAstDeclarationsVisitor.java MiniToAstExpressionVisitor.java MiniToAstFunctionVisitor.java MiniToAstProgramVisitor.java MiniToAstStatementVisitor.java MiniToAstTypeDeclarationVisitor.java MiniToAstTypeVisitor.java

GENERATED=MiniBaseVisitor.java MiniLexer.java MiniLexer.tokens Mini.tokens MiniVisitor.java MiniParser.java MiniBaseListener.java MiniListener.java

all : MiniCompiler.class

%.json : %.mini
	$(JAVA) -cp ${CLASSPATH}:$(CLASSPATH_MOD):$(BUILDPATH) MiniCompiler $< > $@

MiniCompiler.class : antlr.generated ${FILES}
	$(JAVAC) -cp ${CLASSPATH}:$(CLASSPATH_MOD)  -d ${BUILDPATH} ${SOURCEPATH}/*.java ${SOURCEPATH}/ast/*.java

antlr.generated : Mini.g4
	$(JAVA) -cp ${CLASSPATH}:$(CLASSPATH_MOD) org.antlr.v4.Tool -visitor Mini.g4
	touch antlr.generated

clean:
	\rm -rf *generated* ${GENERATED} *.class ast/*.class
