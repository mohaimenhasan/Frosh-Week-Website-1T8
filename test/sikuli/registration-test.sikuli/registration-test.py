screen = Screen(0)
bursary = False

# Settings
Settings.MoveMouseDelay = 0
Settings.SlowMotionDelay = 0

switchApp('Google Chrome')

# Personal Information
screen.type("1373701450896.png", 'John\t')
type('Liu\t')
type('johnliu.dev@gmail.com\t')
type('\t') # Gender
type('\t') # Phone number
type('\t') # Discipline

# Kit Information
type('\t') # T-shirt size

# Health and Safety Information
type('Mama\t')
type('johnliu.dev+mama@gmail.com\t')
type('Mother\t')
type('6173541234\t')
type('\t') # Dietary
type('\t') # Accessibility
type('\t') # Misc

# Payment
if (not bursary):
    type('\t') # Bursary
    type('John Liu\t')
    type('4242424242424242\t')
    type('123\t')
    type('12\t')
    type('13\t')
else:
    type(' \t') # Bursary
    type('\t')
    type('Stuff\t')
    type("I don't need financial support.\t")

type('\n')