from setuptools import setup


setup(
    name='cldfbench_nompers_cldf',
    py_modules=['cldfbench_nompers_cldf'],
    include_package_data=True,
    zip_safe=False,
    entry_points={
        'cldfbench.dataset': [
            'nompers_cldf=cldfbench_nompers_cldf:Dataset',
        ]
    },
    install_requires=[
        'cldfbench',
    ],
    extras_require={
        'test': [
            'pytest-cldf',
        ],
    },
)
