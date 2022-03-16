# Admixture_pipeline
Instructions and notes on running the software Admixture for Ancestry Estimation

Latest Update: 3/16/2022

This protocol is written for running single digest Restriction site-associated DNA (RAD) data.
Please see the [RADseq_pipeline](https://github.com/kiralong/RADseq_pipeline) for instructions on demultiplexing and flitering RAD data before this analysis.

[Admixture](https://dalexander.github.io/admixture/index.html) by D.H Alexander et al. is a software tool for estimating the ancestry of individuals. In this protocol, admixture will be run on a computing cluster using a bash script to submit the runs to the cluster's queue manager and then subseqent graphing of the data is done R. However, there are also R packages for running Admixture and plotting ther results found [here](https://github.com/esteinig/netview) with a helpful tutorial [here](https://github.com/esteinig/netview/blob/master/tutorials/PearlOysterTutorial.md).

## Overall Pipeline Summary
raw RAD reads (fastq file) -> see [RADseq_pipeline](https://github.com/kiralong/RADseq_pipeline) -> format plink input file -> run Admixture -> plot bar plots -> plot K 

### Step 1: Process raw RAD reads
See [RADseq_pipeline](https://github.com/kiralong/RADseq_pipeline) for instructions on how to process raw RAD reads after you get your giant fastq.gz file from the sequencing facility. At the step for running `populations` in `stacks`, you will need to make sure you add the flag `--plink` to have the `populations` module output a plink file. `stacks` will output a `.ped` file. According to `Admixture`
