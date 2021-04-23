From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: ARCH=hexagon unsupported?
Date: Fri, 23 Apr 2021 10:43:11 -0700
Message-ID: <fa0bed95-5ddf-ecad-0613-2f13837578c3@infradead.org>
References: <CAKwvOdngSxXGYAykAbC=GLE_uWGap220=k1zOSxe1ntuC=0wjA@mail.gmail.com>
 <CAK8P3a2DCCjOq+sB+9sRM7XrtnkromCs_+znv3dehqLiYFDQag@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=D07Myy5xgLJyaySINjmTXcck3i4ZrKKFxHv5lMNfn/o=; b=fFdDv8CW5Q5VQidx3RhtqMzTyP
        HNBtGbWC7zjgBRUN9+xa2UcwtMaeChfa6p1gXVQyu8ST0iYNn3/FtApQJN+fHws87aPHm3nxALogR
        pQnxkVRvxv/Nm908rnmL/7pI7QQJkppzlUdYU65HUIi+T1/0ovu9kMQiEVyGfdGzLiL39ELsgodvR
        HjuyFT25bLTzyhzloR988b83SSyiLn3w55IMx4pblhctRrqF75eMWcIL2Adn9bdMqEcwCnVA8qDuM
        /pZpnHeJmUFRMVLNjrJlwEBfBOgSGe4QGuEAk6hjqRMsj7c58CsRc1D+qh+9ZBAr5RbE9ECow+phy
        kA0ClydA==;
In-Reply-To: <CAK8P3a2DCCjOq+sB+9sRM7XrtnkromCs_+znv3dehqLiYFDQag@mail.gmail.com>
Content-Language: en-US
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Arnd Bergmann <arnd@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>
Cc: "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>, Brian Cain <bcain@codeaurora.org>, linux-arch <linux-arch@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>

On 4/23/21 2:36 AM, Arnd Bergmann wrote:
> On Fri, Apr 23, 2021 at 12:12 AM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
>>
>> Arnd,
>> No one can build ARCH=hexagon and
>> https://github.com/ClangBuiltLinux/linux/issues/759 has been open for
>> 2 years.
>>
>> Trying to build
>> $ ARCH=hexagon CROSS_COMPILE=hexagon-linux-gnu make LLVM=1 LLVM_IAS=1 -j71
>>
>> shows numerous issues, the latest of which
>> commit 8320514c91bea ("hexagon: switch to ->regset_get()")
>> has a very obvious typo which misspells the `struct` keyword and has
>> been in the tree for almost 1 year.
> 
> Thank you for looking into it.
> 
>> Why is arch/hexagon/ in the tree if no one can build it?
> 
> Removing it sounds reasonable to me, it's been broken for too long, and
> we did the same thing for unicore32 that was in the same situation
> where the gcc port was too old to build the kernel and the clang
> port never quite work in mainline.
> 
> Guenter also brought up the issue a year ago, and nothing happened.
> I see Brian still occasionally sends an Ack to a patch that gets merged
> through another tree, but he has not send any patches or pull requests
> himself after taking over maintainership from Richard Kuo in 2019,
> and the four hexagon pull requests after 2014 only contained build fixes
> from developers that don't have access to the hardware (Randy Dunlap,
> Viresh Kumar, Mike Frysinger and me).
> 
>        Arnd
> 
> [1] https://lore.kernel.org/lkml/04ca01d633a8$9abb8070$d0328150$@codeaurora.org/

There is no current gcc C compiler in the 3 locations that I know of to look.
The one I tried is v4.6 and it is too old to work with current makefiles.

-- 
~Randy

