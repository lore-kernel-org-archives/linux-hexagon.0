From: "Chen, Rong A" <rong.a.chen@intel.com>
Subject: Re: [kbuild-all] Re: [linux-next:master 9995/11651]
 fs/buffer.c:2254:5: warning: stack frame size (2144) exceeds limit (1024) in
 'block_read_full_folio'
Date: Mon, 16 May 2022 18:09:15 +0800
Message-ID: <416aa517-6813-2227-ddce-34c8b63696e2@intel.com>
References: <202205150051.3RzuooAG-lkp@intel.com>
 <Yn/YsTpOh898B30l@casper.infradead.org>
 <YoAlvnyjEbYV4T1L@dev-arch.thelio-3990X>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652695762; x=1684231762;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=0iuQqxuydIJZPFNzzRya7Q5thdN33xJWufGwf1DqOaI=;
  b=hgOacexZtkGyaiLUKTTdXdjo9cR0dyX29Vn/GHfn8FHJntw8L+hdWfdb
   IqUQrV3rlF2OXvHxuGaFpVfwt7vmmx06Z2d89Ksm7Fwp5z3hOF8z4FvI6
   7YDjvhDChUw4AZSpxw/660sEmyXMS0p/t1qrvIymG3fV4QHZb5Y4eiWZP
   37alBLQHAZxlJdsUVIKmhRkrBBoJWPqxnrYceIatPgpl0noOdUzd9LbNX
   vu+RHIVxGTMGWzL5wh5Jkt+q+r9oq+sYQ0l4fuIMCLtKyQigysdGHIaLY
   yI+CVOnHYiVdqbPtdR66wFJJz5zEqpfh7TLyw5yklFjIKdGlCB8eyaMbp
   Q==;
In-Reply-To: <YoAlvnyjEbYV4T1L@dev-arch.thelio-3990X>
Content-Language: en-US
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: Nathan Chancellor <nathan@kernel.org>, Matthew Wilcox <willy@infradead.org>, Brian Cain <bcain@quicinc.com>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev, kbuild-all@lists.01.org, Linux Memory Management List <linux-mm@kvack.org>, linux-hexagon@vger.kernel.org



On 5/15/2022 5:57 AM, Nathan Chancellor wrote:
> On Sat, May 14, 2022 at 05:28:33PM +0100, Matthew Wilcox wrote:
>> On Sun, May 15, 2022 at 12:23:46AM +0800, kernel test robot wrote:
>>> commit: 2c69e2057962b6bd76d72446453862eb59325b49 [9995/11651] fs: Convert block_read_full_page() to block_read_full_folio()
>>> config: hexagon-randconfig-r041-20220513 (https://download.01.org/0day-ci/archive/20220515/202205150051.3RzuooAG-lkp@intel.com/config)
>>> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 38189438b69ca27b4c6ce707c52dbd217583d046)
>> ...
>>> All warnings (new ones prefixed by >>):
>>>
>>>>> fs/buffer.c:2254:5: warning: stack frame size (2144) exceeds limit (1024) in 'block_read_full_folio' [-Wframe-larger-than]
>>>     int block_read_full_folio(struct folio *folio, get_block_t *get_block)
>>>         ^
>>>     1 warning generated.
>>
>> Now show the warnings that were removed.  This patch renames the
>> function, and I bet there was a similar warning before this patch.
>>
>> But basically, I don't care about stack usage on hexagon with clang.
>> AIUI, it's a known bug.
> 
> For what it's worth, it seems like this is just 256K pages being 256K
> pages... MAX_BUF_PER_PAGE is PAGE_SIZE / 512 so *arr is 2048 bytes big
> in this configuration. You'd see a similar warning with PowerPC but that
> configuration is non-standard:
> 
> fs/buffer.c: In function ‘block_read_full_page’:
> fs/buffer.c:2337:1: warning: the frame size of 2064 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>   2337 | }
>        | ^
> 
> It would be nice if the Intel folks could look at recognizing a function
> rename so that you are not bothered by reports like this.

Hi Nathan, Matthew,

Sorry about this, we'll take a look.

Best Regards,
Rong Chen


> 
> As a side note... Brian, is there any reason for 256K pages to exist for
> Hexagon? This has been an option since Hexagon's introduction but is it
> actually used? 4K pages is the default and the help text says "use with
> caution". Perhaps the choice should be turned off altogether for
> CONFIG_COMPILE_TEST so that we cannot select this configuration and
> bother developers with these reports.
> 
> Cheers,
> Nathan
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
