const initWizard = () => {
  const wizardEl = document.querySelector('.js-wizard');
    // if (!wizardEl) {
    //   return;
    // }


  const wizardHeight = wizardEl.offsetHeight;
  const introStepEl = wizardEl.querySelector('.js-intro-step');
  introStepEl.style.height = `${wizardHeight}px`;
  const nextBtnEls = wizardEl.querySelectorAll('.js-wizard-next');
  const previousBtnEls = wizardEl.querySelectorAll('.js-wizard-previous')
  const wizardStepsEl = wizardEl.querySelector('.js-wizard-steps');

  let stepNumber = 0;

  const updateDisplay = () => {
    wizardStepsEl.classList.remove('is--step-0');
    wizardStepsEl.classList.remove('is--step-1');
    wizardStepsEl.classList.remove('is--step-2');
    wizardStepsEl.classList.remove('is--step-3');
    wizardStepsEl.classList.remove('is--step-4');

    wizardStepsEl.classList.add(`is--step-${stepNumber}`);
  }

  nextBtnEls.forEach((nextBtnEl) => {
    nextBtnEl.addEventListener('click', () => {
      stepNumber += 1;
      updateDisplay();
    });
  });

  previousBtnEls.forEach((previousBtnEl) => {
    previousBtnEl.addEventListener('click', () => {
      stepNumber -= 1;
      updateDisplay();
    });
  });
}

export { initWizard };
