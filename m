From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH 01/20] Hexagon HVX (target/hexagon) README
Date: Wed, 28 Jul 2021 03:11:09 -0500
Message-ID: <b902f367-d911-7e58-2b7e-8a753431eb6c@landley.net>
References: <1625528074-19440-1-git-send-email-tsimpson@quicinc.com>
 <1625528074-19440-2-git-send-email-tsimpson@quicinc.com>
 <1b632e88-43d4-3034-cf7b-d42be056d842@landley.net>
 <SN6PR02MB42054B50C60ABA378256492DB8159@SN6PR02MB4205.namprd02.prod.outlook.com>
 <553c32e8-188c-5b2c-2f4a-a8cfd7b903a9@landley.net>
 <BN7PR02MB4194007550E66EBE877625A6B8E19@BN7PR02MB4194.namprd02.prod.outlook.com>
 <BYAPR02MB55091DE5B976956075B46FADBEE19@BYAPR02MB5509.namprd02.prod.outlook.com>
 <8845de00-ddc7-86a3-600f-6ede81e168c2@landley.net>
 <8192e9bb-a0de-1b2a-271c-ac7323be8244@landley.net>
 <BYAPR02MB48863186EDD71439C60792A0DEE89@BYAPR02MB4886.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FerKPdNaFDKCfscT4TU+H3pHmBs7p/zLOTgpsEPpRyc=;
        b=Gv11WphHbOsIk+BuBIB8WxPTOdewbcOmi2CQEmVUbTH43p3buIqGkAOvHs/kF1fLh5
         ST6o5fM6U/gF9f5waUfHNJ+uhjRJojFvpkuQSQw8zht+Zegt8RDqisYAkboZE/KpBOpq
         59YCYfwekcbiU81okOZNPWq+HZIsTKvfnY/5PwntQDESQLve1xNbXWFEsS0OK3+NXz6X
         aiCKPN4/Mkn0CACeJn1dVWaYkFU8LGi1HXJmKK1lZ1EZ8SNCbzSpLD88Y+mkz8x13Q3X
         aRkIE4G3inHNlX28Q5Pw6GhBiNU7QHlioZrU0bbzqz4SuElJdvvKgSjK4hpuoiq09XGq
         0nFA==
In-Reply-To: <BYAPR02MB48863186EDD71439C60792A0DEE89@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Language: en-US
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Taylor Simpson <tsimpson@quicinc.com>, Sid Manning <sidneym@quicinc.com>, Brian Cain <bcain@quicinc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>
Cc: "ale@rev.ng" <ale@rev.ng>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, "philmd@redhat.com" <philmd@redhat.com>

On 7/26/21 8:59 AM, Taylor Simpson wrote:
>> Anyway, I still hope somebody else has already done most of this in a git
>> tree somewhere. :)
>
> We're working on system mode support for Hexagon, and we plan to upstream it when it is ready.

Yay! Thanks.

While you're at it, why is llvm's cmake config unable to do:

  $ cccnext/cross_bin/hexagon-unknown-linux-musl-cc \
    -Xpreprocessor -P -E - <<< __SIZEOF_POINTER__
  4

I'm trying to genericize that llvm build script to do all the targets musl and
llvm agree on supporting, which means not passing in -DCMAKE_SIZEOF_VOID_P=4
because the compiler ALREADY KNOWS THIS... but cmake/config-ix.cmake line 196 is
REALLY going to barf if we didn't explicitly specify it on the command line? Are
the llvm developers not _aware_ of the "cc -E -dM - < /dev/null" trick? Even if
they aren't, why couldn't they just sizeof(void *) in a header file?

*shrug* I can do the above trick in the wrapper script and then provide
-DCMAKE_SIZEOF_VOID_P=$BLAH on the command line, it just seems DEEPLY pointless
to go to all the trouble of having a ./configure that has to be manually told
stuff the compiler already knows.

Confused,

Rob
