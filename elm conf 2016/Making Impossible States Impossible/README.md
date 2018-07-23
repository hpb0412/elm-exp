# Making Impossible States Impossible - Richard Feldman

An implementation follows Richard Feldman's presentation at Elm Conf 2016: https://www.youtube.com/watch?v=IcgmSRJHu_8

This folder contains the Survey app.

For the purpose of the talk, I skipped the answer feature.

I only focus on navigating feature (Back & Forward).

For simplicity, I put all model code inside `Questions.elm` instead of separating into 2 files `Question.elm` and `History.elm`.

TODO:

- [ ] answer this question: "should I hide the implementation of `rendering function` (`toHtml`, `questionToHtml`) inside module?"
- [ ] improve clumsy implementation of back/forward function
- [ ] split `Questions.elm` to `Question.elm` and `History.elm`
