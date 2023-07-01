import React from 'react'
import clsx from 'clsx'
import styles from './styles.module.css'

interface FeatureItem {
  title: string
  Svg: React.ComponentType<React.ComponentProps<'svg'>>
  description: JSX.Element
}

const FeatureList: FeatureItem[] = [
  {
    title: 'User Friendly',
    Svg: require('@site/static/img/undraw_docusaurus_mountain.svg').default,
    description: (
      <>
        Providing a more practical and user-friendly way to access OCPI documentation.
      </>
    )
  },
  {
    title: 'Making OCPI Accesible',
    Svg: require('@site/static/img/undraw_docusaurus_tree.svg').default,
    description: (
      <>
        More accessible OCPI documentation can help to accelerate the adoption of OCPI and make it easier for developers
        to build interoperable EV charging solutions.
      </>
    )
  },
  {
    title: 'EV Roaming Foundation',
    Svg: require('@site/static/img/undraw_docusaurus_react.svg').default,
    description: (
      <>
        This site is not associated with EV Roaming Foundation, and recommends that users always
        consult the official OCPI documentation in https://evroaming.org.
      </>
    )
  }
]

function Feature ({ title, Svg, description }: FeatureItem) {
  return (
    <div className={clsx('col col--4')}>
      <div className='text--center'>
        <Svg className={styles.featureSvg} role='img' />
      </div>
      <div className='text--center padding-horiz--md'>
        <h3>{title}</h3>
        <p>{description}</p>
      </div>
    </div>
  )
}

export default function HomepageFeatures (): JSX.Element {
  return (
    <section className={styles.features}>
      <div className='container'>
        <div className='row'>
          {FeatureList.map((props, idx) => (
            <Feature key={idx} {...props} />
          ))}
        </div>
      </div>
    </section>
  )
}
