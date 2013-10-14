# MKBlockSegues

UIViewController's category to use segues in the way they should have been implemented.

## Why

Because I was tired of splitting my code into `-prepareForSegue:`.

## Example usage:

	  [self ms_performSegueWithIdentifier:@"NewPushSegue" sender:self prepareBlock:^(UIStoryboardSegue *segue) {
      // do the staff you used to do in prepareForSegue:
      NextViewController *nextViewController = segue.destinationViewController;
      [productsViewController initializeWithSetup:setup];
    }];

Then in `-prepareForSegue:` just call the handler, without writing nasty if-then-else:

    - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
    {
      [self ms_handlePerformedSegue:segue];
    }

## Contact

Marco Sero

- http://www.marcosero.com
- http://twitter.com/marcosero 
- marco@marcosero.com

## License

Nimble is available under the MIT license. See the file LICENSE.