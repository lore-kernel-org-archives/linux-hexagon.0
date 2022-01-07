From: Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] fs: btrfs: Disable BTRFS on platforms having 256K pages
Date: Fri, 7 Jan 2022 13:21:53 +0800
Message-ID: <7fc839d7-c13d-d658-5247-62540d76e7c0@suse.com>
References: <a16c31f3caf448dda5d9315e056585b6fafc22c5.1623302442.git.christophe.leroy@csgroup.eu>
 <6c7a6762-6bec-842b-70b4-4a53297687d1@gmx.com>
 <CAEg-Je9UJDJ=hvLLqQDsHijWnxh1Z1CwaLKCFm+-bLTfCFingg@mail.gmail.com>
 <db88497c-ea17-27ca-6158-2a987acb7a1c@gmx.com>
 <87bl0o2lgo.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1641532942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+uLY0XYI6R+LPrwdz1fmC76iiLA2yfMqWxPreldZEhs=;
        b=ndFstp9aHYCX0qtH7YWlOH5ZsOiYJqUDFEGFAdJ19umzj7Nwxooa1nL9nZpc4/HMevjLcj
        C7pWmsFSPgNEe2RAtJPxoy3DF7p/WNWmcBlNejI1U5a3zxgaXfVQmev7w1/T/cSti68G5m
        o66Ve5iMWTQ2LDw1omgc6UKbzoi/dJ8=
Content-Language: en-US
In-Reply-To: <87bl0o2lgo.fsf@mpe.ellerman.id.au>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Michael Ellerman <mpe@ellerman.id.au>, Qu Wenruo <quwenruo.btrfs@gmx.com>, Neal Gompa <ngompa13@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, linux-hexagon@vger.kernel.org, Hector Martin <marcan@marcan.st>



On 2022/1/7 12:55, Michael Ellerman wrote:
> Qu Wenruo <quwenruo.btrfs@gmx.com> writes:
>> On 2022/1/7 00:31, Neal Gompa wrote:
>>> On Wed, Jan 5, 2022 at 7:05 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>>
>>>> Hi Christophe,
>>>>
>>>> I'm recently enhancing the subpage support for btrfs, and my current
>>>> branch should solve the problem for btrfs to support larger page sizes.
>>>>
>>>> But unfortunately my current test environment can only provide page size
>>>> with 64K or 4K, no 16K or 128K/256K support.
>>>>
>>>> Mind to test my new branch on 128K page size systems?
>>>> (256K page size support is still lacking though, which will be addressed
>>>> in the future)
>>>>
>>>> https://github.com/adam900710/linux/tree/metadata_subpage_switch
>>>>
>>>
>>> The Linux Asahi folks have a 16K page environment (M1 Macs)...
>>
>> Su Yue kindly helped me testing 16K page size, and it's pretty OK there.
>>
>> So I'm not that concerned.
>>
>> It's 128K page size that I'm a little concerned, and I have not machine
>> supporting that large page size to do the test.
> 
> Did Christophe say he had a 128K system to test on?
> 
> In mainline powerpc only supports 4K/16K/64K/256K.
> 
> AFAIK there's no arch with 128K page size support, but that's only based
> on some grepping, maybe it's hidden somewhere.

My bad, I thought there would be 128K since there is 256K and 64K 
support, but that's totally wrong.

I'll get PPC guys informed when the 256K page size problem is solved, 
and then ask for your help.

Thanks,
Qu

> 
> cheers
> 

