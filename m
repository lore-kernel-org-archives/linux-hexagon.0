From: Nathan Chancellor <nathan@kernel.org>
Subject: Re: how can we test the hexagon port in mainline
Date: Wed, 7 Jul 2021 10:42:27 -0700
Message-ID: <1ee8fc44-3e8c-91c0-7909-a636757dbda4@kernel.org>
References: <20210623141854.GA32155@lst.de>
 <08df01d7683d$8f5b7b70$ae127250$@codeaurora.org>
 <CAK8P3a28_0KJpcLRQrDhFk8-ndxmfk7-Q2_qcRRiYkyh-NNZUQ@mail.gmail.com>
 <08e101d76842$94f78a60$bee69f20$@codeaurora.org>
 <20210623151746.GA4247@lst.de>
 <CAK8P3a2bG64ARjpwQ0ZhQ9P0g8B-=AwcHHAbYBXBS4B6Fy9pQw@mail.gmail.com>
 <YNQE0YJzC2xmWg+2@Ryzen-9-3900X.localdomain> <20210707141054.GA24828@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625679750;
        bh=Tf1JbiTjBYSqr3fsXG06VqkmXcrZq/92XkeTceZpn5M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hMbfu1g6APDl53Tn9rXQc5wtA1iNOivGcl10HL4v7YRByVgCxyh0xvlSWSpgWdqYr
         CMCYMbZV47X57YXuIcZgzSKPchRe1TMdCdsSlawD+U/vdY3abWvsV0TGF0f0XAm3K+
         2AQKV1DX96tVCcg2ddXua6HfhpBDx7YzKcOkBIKyjl+vG0o4GR+4Kic7izBfyCY01T
         5UBoXc4DhRmBA6UFN7qiCrkjycxFMK9Gzi+vCwbmI9M9TnXGZsV8ZxwTL82mszW6vl
         kEIN2t1tnLYOTfrC+LfeJ7jXxkvVcWkplDF3YyygPYbFtCLXq5TtySCOnXiA9hj95s
         DQiDNDUdJAwSQ==
In-Reply-To: <20210707141054.GA24828@lst.de>
Content-Language: en-US
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Christoph Hellwig <hch@lst.de>, Brian Cain <bcain@codeaurora.org>, Sid Manning <sidneym@codeaurora.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>, clang-built-linux@googlegroups.com

Hi Christoph,

On 7/7/2021 7:10 AM, Christoph Hellwig wrote:
> On Wed, Jun 23, 2021 at 09:06:41PM -0700, Nathan Chancellor wrote:
>> I've reported this upstream with you on CC:
>>
>> https://bugs.llvm.org/show_bug.cgi?id=50838
> 
> I've not actually got any mail from that Cc..

Sorry, I directed that at Arnd. I should have kept you in the loop too.

>> Christoph, that toolchain should work (I had to install libtinfo5 and
>> libc++1-7 on Debian Buster):
>>
>> $ export PATH=$HOME/tmp/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin:$PATH
>>
>> $ make -skj"$(nproc)" ARCH=hexagon CROSS_COMPILE=hexagon-unknown-linux-musl LLVM=1 LLVM_IAS=1 defconfig all
> 
> hch@brick:~/work/linux$ make -j4 ARCH=hexagon
> CROSS_COMPILE=hexagon-unknown-linux-musl LLVM=1 LLVM_IAS=1 defconfig all
> HOSTCC  scripts/basic/fixdep
> clang: error while loading shared libraries: libtinfo.so.5: cannot open shared object file: No such file or directory

Hmmm, is that with libtinfo5 installed (or whatever the ncurses-compat 
equivalent is on your distribution installed)? I had that problem on 
Debian until I insta

Brian/Sid, it might be worth flipping LLVM_ENABLE_TERMINFO to OFF during 
your cmake configuration so that there are less dynamic dependencies and 
it is easier for more people to run the toolchain. Android's clang team 
did the same thing:

https://github.com/android/ndk/issues/574

With https://reviews.llvm.org/D42055, there should not be too much of a 
sacrifice.

Cheers,
Nathan
