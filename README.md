# Admixture_pipeline
Instructions and notes on running the software `Admixture` for Ancestry Estimation

Latest Update: 3/16/2022

This protocol was written for running single digest Restriction site-associated DNA (RAD) data. 
Please see the [RADseq_pipeline](https://github.com/kiralong/RADseq_pipeline) for instructions on demultiplexing and flitering RAD data before this analysis.

[Admixture](https://dalexander.github.io/admixture/index.html) by D.H Alexander et al. is a software tool for estimating the ancestry of individuals. In this protocol, `Admixture` will be run on a computing cluster using a bash script to submit the runs to the cluster's queue manager and then subseqent graphing of the data is done `R`. However, there are also R packages for running Admixture and plotting ther results found [here](https://github.com/esteinig/netview) with a helpful tutorial [here](https://github.com/esteinig/netview/blob/master/tutorials/PearlOysterTutorial.md).

## Overall Pipeline Summary
raw RAD reads (fastq file) -> see [RADseq_pipeline](https://github.com/kiralong/RADseq_pipeline) -> format PLINK input file -> run Admixture -> plot cv error -> plot stacked bar plots

## Required Software and Installation
Before starting, you'll need to install [PLINK](https://www.cog-genomics.org/plink/) and [Admixture](https://dalexander.github.io/admixture/download.html). I used `wget` with their url's on the command line to download both. `unzip plink_linux_x86_64_20220305.zip` and `tar xfvz admixture_linux-1.3.0.tar.gz`. Make sure if you are on a computing cluster you add both software to your path so you can call the programs from anywhere in your user section of the cluster. 

### Step 1: Process raw RAD reads
See [RADseq_pipeline](https://github.com/kiralong/RADseq_pipeline) for instructions on how to process raw RAD reads after you get your giant fastq.gz file from the sequencing facility. At the step for running `populations` in `stacks`, you will need to make sure you add the flag `--plink` to have the `populations` module output a PLINK file. `stacks` will output a `.ped` file.

For an example script of running `populations` to get the `.ped` file see [run_populations.sh](run_populations.sh). `Stacks` will output two files: `populations.plink.ped` and `populations.plink.map`. 

### Step 2: Format plink `.ped` input file for `Admixture`
According to the `Admixture` [manual](https://dalexander.github.io/admixture/admixture-manual.pdf), `Admixture` can use binary PLINK `.bed` files, regular PLINK `.ped` files, and EIGENSTRAT `.geno` files. However, when I tried to run the `.ped` after removing the `stacks` header, I kept getting errors from `Admixture` that the  `.ped` file was formatted incorrectly. After perusing some forums, google groups, and peers it seems like people have had the most success converting to a `.bed` format. So use the script [format_plink.sh](format_plink.sh) to convert the `.ped` and `.map` files to a `.bed` format. Note that in this script you need to set your working directory and there is a loop of `sed` commands to rename my population names to only numeric names.

### Step 3: Run `Admixture`
Next, run the script [run_admixture.sh](run_admixture.sh) to submit a job and run admixture to the number of k populations desired. In my case, I have 9 sampled populations so I ran K 1-9, captured the output for graphing and the cv error to find my ideal k. In the loop, you can change the maximal k that you want instead of 9. 

## Step 4: Plot cv error to find ideal k value
[Run_admixture.sh](run_admixture.sh) will make a new directory for each specified K to hold the outputs. To find the ideal k for your dataset, you need to plot a line graph and look for the smallest cv error value. Go to the tail of the `kvalue.log` in each directory and copy the value labled `CV error (K=1): 0.27774` Of all your k values, the one with the lowest value is your best k.

## Step 5: Plot stacked bar plots
Lastly, you'll want to make stacked bar plots of all your individuals and their respective k values. I downloaded the file `admixture_K1.tsv` and put this into R to plot it. See [admixture_plot.R](admixture_plot.R) for how I made my admixture plots. 

Note that I wanted to order the stacked bar plots in descending order of the K values but I currently can't get this to work. 

