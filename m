From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: ARCH=hexagon unsupported?
Date: Fri, 23 Apr 2021 15:26:57 -0700
Message-ID: <42ab3057-3b43-7f98-6387-6e79761d2d3f@infradead.org>
References: <CAKwvOdngSxXGYAykAbC=GLE_uWGap220=k1zOSxe1ntuC=0wjA@mail.gmail.com>
 <CAK8P3a2DCCjOq+sB+9sRM7XrtnkromCs_+znv3dehqLiYFDQag@mail.gmail.com>
 <fa0bed95-5ddf-ecad-0613-2f13837578c3@infradead.org>
 <CAK8P3a0ttLxzP0J-mocxB2TkfEYJYj37TdW=uM65fB4giC_qeg@mail.gmail.com>
 <026d01d73877$386a1920$a93e4b60$@codeaurora.org>
 <027401d7387e$f5630120$e0290360$@codeaurora.org>
 <24da08a4-e055-d8ac-8214-97d86cdcfd3d@infradead.org>
 <02a501d7388f$8dfb3b90$a9f1b2b0$@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=9p+f2yEK4EX631yr0nLf67Yo+8aAuwLas6USm3q+guE=; b=VUsIIiWaXRIitxr+LIP/9TRx/a
        oq7jC/A3vVfw8DgbkA34V4c2wxPT1SBd93piZo51HTgdM5tCOxBTDrNtxg47d24d0OakSa2UkQrV0
        0oxqFuFn5G5OrsJNiGvazc3aCc3q3wE6oz/rls3qmvTJc/FV87lROU9pYxUv2VaotyGgJVzzuEOy4
        CG1W99HbLWakwMa4MK7z9YkATKCaccnYdylCs0G860wOFLDnGG7XqeVitcHcl7rXTFJYlVHm7NgmJ
        F0eim+xuMuNpgQVFKazrBI7DezgINd1d0zEV+leI74tfG29HJsBBp4BDp5iQE6p79sHgtyjd11L/3
        RAXIiLew==;
In-Reply-To: <02a501d7388f$8dfb3b90$a9f1b2b0$@codeaurora.org>
Content-Language: en-US
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: bcain@codeaurora.org, 'Arnd Bergmann' <arnd@kernel.org>
Cc: 'Nick Desaulniers' <ndesaulniers@google.com>, "'open list:QUALCOMM HEXAGON...'" <linux-hexagon@vger.kernel.org>, 'clang-built-linux' <clang-built-linux@googlegroups.com>, 'linux-arch' <linux-arch@vger.kernel.org>, 'Guenter Roeck' <linux@roeck-us.net>

On 4/23/21 3:25 PM, Brian Cain wrote:
>> -----Original Message-----
>> From: Randy Dunlap <rdunlap@infradead.org>
> ...
>>> It's published as a container in the Gitlab Container Registry.  You can use
>> docker/podman to pull "registry.gitlab.com/qemu-
>> project/qemu/qemu/debian-hexagon-cross" in order to use it.
>>
>> Hi Brian,
>>
>> Maybe that will be useful to someone.
>>
>> However, I am looking for something like a tarball that I can download and
>> deploy locally, like one can find at these locations:
>>
>> https://toolchains.bootlin.com/
>> https://download.01.org/0day-ci/cross-package/
>> https://mirrors.edge.kernel.org/pub/tools/crosstool/
> 
> Randy,
> 
> 	I 100% agree, I would prefer a tarball myself.  I have been working with the team to produce the tarball and we haven't been able to deliver that yet.  No good excuses here, only bad ones: somewhat tied up in process bureaucracy.
> 
> I can share the recipe that was used to build the toolchain in the container.  No Dockerfile required, just a shell script w/mostly cmake + make commands.  All of the sources are public, but musl is a downstream-public repo because we haven't landed the hexagon support in upstream musl yet.

Hi Brian,
I can wait. :)

Thanks.

