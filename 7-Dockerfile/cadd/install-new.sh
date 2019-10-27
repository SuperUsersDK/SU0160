#!/bin/bash

set -e

echo "CADD-v1.5 (c) University of Washington, Hudson-Alpha Institute for Biotechnology and Berlin Institute of Health 2013-2019. All rights reserved."
echo ""

SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname "$SCRIPT")

cd $BASEDIR

# check whether conda and snakemake are available

if [ "$(type conda)" == '' ]
then
    echo 'Conda seems not to be available. Are you sure conda is installed and available in the current $PATH ?';
    exit 1;
fi

echo "The following questions will quide you through selecting the files and dependencies needed for CADD."
echo "After this, you will see an overview of the selected files before the download and installation starts."
echo "Please note, that for successfully running CADD locally, you will need the conda environment and at least one set of annotations."
echo ""

ENV=true
GRCh38v15=true
GRCh37=false
GRCh38=false

if [ "$GRCh37" = false ] && [ "$GRCh38" = false ] && [ "$GRCh38v15" = false ]
then
    echo "You have choosen to not install any of the available CADD models. Discontinuing installation.";
    exit 0;
fi

INDELS=false
NOCANNO=false
INCANNO=false
PRESCORE=false
ANNOTATIONS=false

### FILE CONFIGURATION

ANNOTATION_GRCh37="http://krishna.gs.washington.edu/download/CADD/v1.4/GRCh37/annotationsGRCh37.tar.gz"
ANNOTATION_GRCh38="http://krishna.gs.washington.edu/download/CADD/v1.4/GRCh38/annotationsGRCh38.tar.gz"
ANNOTATION_GRCh38v15="http://krishna.gs.washington.edu/download/CADD/v1.5/GRCh38/annotationsGRCh38.tar.gz"
PRESCORE_GRCh37="http://krishna.gs.washington.edu/download/CADD/v1.4/GRCh37/whole_genome_SNVs.tsv.gz"
PRESCORE_GRCh38="http://krishna.gs.washington.edu/download/CADD/v1.4/GRCh38/whole_genome_SNVs.tsv.gz"
PRESCORE_GRCh38v15="http://krishna.gs.washington.edu/download/CADD/v1.5/GRCh38/whole_genome_SNVs.tsv.gz"
PRESCORE_INCANNO_GRCh37="http://krishna.gs.washington.edu/download/CADD/v1.4/GRCh37/whole_genome_SNVs_inclAnno.tsv.gz"
PRESCORE_INCANNO_GRCh38="http://krishna.gs.washington.edu/download/CADD/v1.4/GRCh38/whole_genome_SNVs_inclAnno.tsv.gz"
PRESCORE_INCANNO_GRCh38v15="http://krishna.gs.washington.edu/download/CADD/v1.5/GRCh38/whole_genome_SNVs_inclAnno.tsv.gz"
PRESCORE_GRCh37_INDEL="http://krishna.gs.washington.edu/download/CADD/v1.4/GRCh37/InDels.tsv.gz"
PRESCORE_GRCh38_INDEL="http://krishna.gs.washington.edu/download/CADD/v1.4/GRCh38/InDels.tsv.gz"
PRESCORE_GRCh38v15_INDEL="http://krishna.gs.washington.edu/download/CADD/v1.5/GRCh38/InDels.tsv.gz"
PRESCORE_INCANNO_GRCh37_INDEL="http://krishna.gs.washington.edu/download/CADD/v1.4/GRCh37/InDels_inclAnno.tsv.gz"
PRESCORE_INCANNO_GRCh38_INDEL="http://krishna.gs.washington.edu/download/CADD/v1.4/GRCh38/InDels_inclAnno.tsv.gz"
PRESCORE_INCANNO_GRCh38v15_INDEL="http://krishna.gs.washington.edu/download/CADD/v1.5/GRCh38/InDels_inclAnno.tsv.gz"

### OVERVIEW SELECTION

echo ""
echo "The following will be loaded: (disk space occupied)"

if [ "$ENV" = true ]
then
    if [ "$GRCh38v15" = 'true' ]
    then
        echo " - Setup of the virtual environment including all dependencies for CADD v1.5 (3 GB)."
    fi

    if [ "$GRCh38" = 'true' ] || [ "$GRCh37" = 'true' ]
    then
        echo " - Setup of the virtual environment including all dependencies for CADD v1.4 (3 GB)."
    fi
fi

if [ "$GRCh37" = true ]
then
    if [ "$ANNOTATIONS" = true ]
    then
        echo " - Download CADD annotations for GRCh37-v1.4 (98 GB)"
    fi

    if [ "$PRESCORE" = true ]
    then
        if [ "$INCANNO" = true ]
        then
            echo " - Download prescored SNV inclusive annotations for GRCh37-v1.4 (231 GB)"
            if [ "$INDELS" = true ]
            then
                echo " - Download prescored InDels inclusive annotations for GRCh37-v1.4 (3 GB)"
            fi
        fi
        if [ "$NOANNO" = true ]
        then
            echo " - Download prescored SNV (without annotations) for GRCh37-v1.4 (78 GB)"
            if [ "$INDELS" = true ]
            then
                echo " - Download prescored InDels (without annotations) for GRCh37-v1.4 (0.6 GB)"
            fi
        fi
    fi
fi

if [ "$GRCh38" = true ]
then
    if [ "$ANNOTATIONS" = true ]
    then
        echo " - Download CADD annotations for GRCh38-v1.4 (194 GB)"
    fi

    if [ "$PRESCORE" = true ]
    then
        if [ "$INCANNO" = true ]
        then
            echo " - Download prescored SNV inclusive annotations for GRCh38-v1.4 (323 GB)"
            if [ "$INDELS" = true ]
            then
                echo " - Download prescored InDels inclusive annotations for GRCh38-v1.4 (9 GB)"
            fi
        fi
        if [ "$NOANNO" = true ]
        then
            echo " - Download prescored SNV (without annotations) for GRCh38-v1.4 (79 GB)"
            if [ "$INDELS" = true ]
            then
                echo " - Download prescored InDels (without annotations) for GRCh38-v1.4 (1 GB)"
            fi
        fi
    fi
fi

if [ "$GRCh38v15" = true ]
then
    if [ "$ANNOTATIONS" = true ]
    then
        echo " - Download CADD annotations for GRCh38-v1.5 (168 GB)"
    fi

    if [ "$PRESCORE" = true ]
    then
        if [ "$INCANNO" = true ]
        then
            echo " - Download prescored SNV inclusive annotations for GRCh38-v1.5 (292 GB)"
            if [ "$INDELS" = true ]
            then
                echo " - Download prescored InDels inclusive annotations for GRCh38-v1.5 (7 GB)"
            fi
        fi
        if [ "$NOANNO" = true ]
        then
            echo " - Download prescored SNV (without annotations) for GRCh38-v1.5 (80 GB)"
            if [ "$INDELS" = true ]
            then
                echo " - Download prescored InDels (without annotations) for GRCh38-v1.5 (1 GB)"
            fi
        fi
    fi
fi

echo "Please make sure you have enough disk space available."

### INSTALLATION

if [ "$ENV" = true ]
then
    if [ "$GRCh38v15" = 'true' ]
    then
        echo "Setting up virtual environment for CADD v1.5"
        conda env create -f src/environment_v1.5.yml
    fi

    if [ "$GRCh38" = 'true' ] || [ "$GRCh37" = 'true' ]
    then
        echo "Setting up virtual environment for CADD v1.4"
        conda env create -f src/environment.yml
    fi

fi

# download a file and it index and check both md5 sums
function download_variantfile()
{
    echo $1
    wget -c $2
    wget -c $2.tbi
    wget $2.md5
    wget $2.tbi.md5
    md5sum -c *.md5
    rm *.md5
}

if [ "$GRCh37" = true ]
then
    if [ "$ANNOTATIONS" = true ]
    then
        echo "Downloading CADD annotations for GRCh37-v1.4 (98 GB)"
        mkdir -p data/annotations/
        cd data/annotations/
        wget -c ${ANNOTATION_GRCh37} -O annotationsGRCh37.tar.gz
        wget ${ANNOTATION_GRCh37}.md5 -O annotationsGRCh37.tar.gz.md5
        md5sum -c annotationsGRCh37.tar.gz.md5
        echo "Unpacking CADD annotations for GRCh37-v1.4"
        tar -zxf annotationsGRCh37.tar.gz
        rm annotationsGRCh37.tar.gz
        rm annotationsGRCh37.tar.gz.md5
        mv GRCh37 GRCh37_v1.4
        cd $OLDPWD
    fi

    if [ "$PRESCORE" = true ]
    then
        if [ "$NOANNO" = true ]
        then
            mkdir -p data/prescored/GRCh37_v1.4/no_anno/
            cd data/prescored/GRCh37_v1.4/no_anno/
            download_variantfile "Downloading prescored SNV without annotations for GRCh37-v1.4 (78 GB)" ${PRESCORE_GRCh37}
            if [ "$INDELS" = true ]
            then
                download_variantfile "Downloading prescored InDels without annotations for GRCh37-v1.4 (1 GB)" ${PRESCORE_GRCh37_INDEL}
            fi
            cd $OLDPWD
        fi

        if [ "$INCANNO" = true ]
        then
            mkdir -p data/prescored/GRCh37_v1.4/incl_anno/
            cd data/prescored/GRCh37_v1.4/incl_anno/
            download_variantfile "Downloading prescored SNV inclusive annotations for GRCh37-v1.4 (231 GB)" ${PRESCORE_INCANNO_GRCh37}
            if [ "$INDELS" = true ]
            then
                download_variantfile "Downloading prescored InDels inclusive annotations for GRCh37-v1.4 (3 GB)" ${PRESCORE_INCANNO_GRCh37_INDEL}
            fi
            cd $OLDPWD
        fi
    fi
fi

if [ "$GRCh38" = true ]
then

    if [ "$ANNOTATIONS" = true ]
    then
        echo "Downloading CADD annotations for GRCh38-v1.4 (194 GB)"
        mkdir -p data/annotations/
        cd data/annotations/
        wget -c $ANNOTATION_GRCh38 -O annotationsGRCh38.tar.gz
        wget $ANNOTATION_GRCh38.md5 -O annotationsGRCh38.tar.gz.md5
        md5sum -c annotationsGRCh38.tar.gz.md5
        echo "Unpacking CADD annotations for GRCh38-v1.4"
        tar -zxf annotationsGRCh38.tar.gz
        rm annotationsGRCh38.tar.gz
        rm annotationsGRCh38.tar.gz.md5
        mv GRCh38 GRCh38_v1.4
        cd $OLDPWD
    fi

    if [ "$PRESCORE" = true ]
    then
        if [ "$NOANNO" = true ]
        then
            mkdir -p data/prescored/GRCh38_v1.4/no_anno/
            cd data/prescored/GRCh38_v1.4/no_anno/
            download_variantfile "Downloading prescored SNV without annotations for GRCh38-v1.4 (79 GB)" ${PRESCORE_GRCh38}
            if [ "$INDELS" = true ]
            then
                download_variantfile "Downloading prescored InDels without annotations for GRCh38-v1.4 (1 GB)" ${PRESCORE_GRCh38_INDEL}
            fi
            cd $OLDPWD
        fi

        if [ "$INCANNO" = true ]
        then
            mkdir -p data/prescored/GRCh38_v1.4/incl_anno/
            cd data/prescored/GRCh38_v1.4/incl_anno/
            download_variantfile "Downloading prescored SNV inclusive annotations for GRCh38-v1.4 (323 GB)" ${PRESCORE_INCANNO_GRCh38}
            if [ "$INDELS" = true ]
            then
                download_variantfile "Downloading prescored InDels inclusive annotations for GRCh38-v1.4 (9 GB)" ${PRESCORE_INCANNO_GRCh38_INDEL}
            fi
            cd $OLDPWD
        fi
    fi
fi

if [ "$GRCh38v15" = true ]
then

    if [ "$ANNOTATIONS" = true ]
    then
        echo "Downloading CADD annotations for GRCh38-v1.5 (168 GB)"
        mkdir -p data/annotations/
        cd data/annotations/
        wget -c ${ANNOTATION_GRCh38v15} -O annotationsGRCh38.tar.gz
        wget ${ANNOTATION_GRCh38v15}.md5 -O annotationsGRCh38.tar.gz.md5
        md5sum -c annotationsGRCh38.tar.gz.md5
        echo "Unpacking CADD annotations for GRCh38-v1.5"
        tar -zxf annotationsGRCh38.tar.gz
        rm annotationsGRCh38.tar.gz
        rm annotationsGRCh38.tar.gz.md5
        cd $OLDPWD
    fi

    if [ "$PRESCORE" = true ]
    then
        if [ "$NOANNO" = true ]
        then
            mkdir -p data/prescored/GRCh38_v1.5/no_anno/
            cd data/prescored/GRCh38_v1.5/no_anno/
            download_variantfile "Downloading prescored SNV without annotations for GRCh38-v1.5 (80 GB)" ${PRESCORE_GRCh38v15}
            if [ "$INDELS" = true ]
            then
                download_variantfile "Downloading prescored InDels without annotations for GRCh38-v1.5 (1 GB)" ${PRESCORE_GRCh38v15_INDEL}
            fi
            cd $OLDPWD
        fi

        if [ "$INCANNO" = true ]
        then
            mkdir -p data/prescored/GRCh38_v1.5/incl_anno/
            cd data/prescored/GRCh38_v1.5/incl_anno/
            download_variantfile "Downloading prescored SNV inclusive annotations for GRCh38-v1.5 (292 GB)" ${PRESCORE_INCANNO_GRCh38v15}
            if [ "$INDELS" = true ]
            then
                download_variantfile "Downloading prescored InDels inclusive annotations for GRCh38-v1.5 (9 GB)" ${PRESCORE_INCANNO_GRCh38v15_INDEL}
            fi
            cd $OLDPWD
        fi
    fi
fi
