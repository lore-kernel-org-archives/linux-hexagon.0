From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] compiler/gcc: Raise minimum GCC version for kernel builds
 to 4.8
Date: Tue, 26 May 2020 09:03:55 -0700
Message-ID: <8c5f8a2c-0ca2-b2f2-4278-d02198d4dd8d@roeck-us.net>
References: <20200526153004.GA74229@roeck-us.net>
 <CAKwvOdnrsCCt_HU+fows6kBCs2jGcikDtMm_otQSKFEgqfojJw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eGb9XhhLPF68O3XDsaI4D+tEZGMmHGhI61X3uwFimXA=;
        b=fRFfWPeypSD55tmdNaBabONqew41csWWML9UWHrI9wYQdVzAcFvqMNfFucxgdzMZx1
         uIRZKKJFbjBX3OTuaqICpa4g2bchHkc56D8yxNvyedBYBysts0jiQsgLgYk4QuRWXo4Z
         3d/Jee4sho7Fjdrql81FUCOUlyxmGBoMz4vUdgO1rCHWVCyoL8bN7Ubqk8vHUPrvbL15
         Z5OU7gNRG2P3rq0+hDlf420F0YX8FYH71FLKRmQfLRuTZW2gGLuSm4iUDMRdaIFfWHpK
         ulbJX0iyo3oIAoC0tvDPmqwuhD33AMIyUX+kTP9h20LJfvc3WJ7y8iFuw2/9MtRDyDDL
         HQkw==
In-Reply-To: <CAKwvOdnrsCCt_HU+fows6kBCs2jGcikDtMm_otQSKFEgqfojJw@mail.gmail.com>
Content-Language: en-US
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Will Deacon <will@kernel.org>, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Masahiro Yamada <masahiroy@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>

Hi Nick,

On 5/26/20 8:40 AM, Nick Desaulniers wrote:
> On Tue, May 26, 2020 at 8:30 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Mon, May 11, 2020 at 09:41:37PM +0100, Will Deacon wrote:
>>> It is very rare to see versions of GCC prior to 4.8 being used to build
>>> the mainline kernel. These old compilers are also known to have codegen
>>> issues which can lead to silent miscompilation:
>>>
>>> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145
>>>
>>> Raise the minimum GCC version to 4.8 for building the kernel and remove
>>> some tautological Kconfig dependencies as a consequence.
>>
>> My hexagon compiler is v4.6.1, and I have been unable to find a more
>> recent version. Does anyone happen to have a pointer to a hexagon toolchain
>> with gcc 4.8 or later ?
> 
> IIUC, hexagon moved to LLVM, though that target still has issues
> building the kernel.
> https://github.com/ClangBuiltLinux/linux/issues?q=is%3Aopen+is%3Aissue+label%3A%22%5BARCH%5D+hexagon%22
> 

That won't help me for my build tests. It is bad enough having to maintain
one compiler. I don't want to add another one to the mix, and I'll happily
leave llvm build tests for ClangBuiltLinux. Guess I'll have to stop hexagon
test builds starting with 5.8.

Guenter
