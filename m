From: Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH] fs: btrfs: Disable BTRFS on platforms having 256K pages
Date: Fri, 7 Jan 2022 11:45:38 +0900
Message-ID: <d8cd9082-4514-9c6c-85c7-418356f1f66d@marcan.st>
References: <a16c31f3caf448dda5d9315e056585b6fafc22c5.1623302442.git.christophe.leroy@csgroup.eu>
 <6c7a6762-6bec-842b-70b4-4a53297687d1@gmx.com>
 <CAEg-Je9UJDJ=hvLLqQDsHijWnxh1Z1CwaLKCFm+-bLTfCFingg@mail.gmail.com>
 <db88497c-ea17-27ca-6158-2a987acb7a1c@gmx.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Language: en-US
In-Reply-To: <db88497c-ea17-27ca-6158-2a987acb7a1c@gmx.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Neal Gompa <ngompa13@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, linux-hexagon@vger.kernel.org

On 2022/01/07 9:13, Qu Wenruo wrote:
> 
> 
> On 2022/1/7 00:31, Neal Gompa wrote:
>> On Wed, Jan 5, 2022 at 7:05 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>
>>> Hi Christophe,
>>>
>>> I'm recently enhancing the subpage support for btrfs, and my current
>>> branch should solve the problem for btrfs to support larger page sizes.
>>>
>>> But unfortunately my current test environment can only provide page size
>>> with 64K or 4K, no 16K or 128K/256K support.
>>>
>>> Mind to test my new branch on 128K page size systems?
>>> (256K page size support is still lacking though, which will be addressed
>>> in the future)
>>>
>>> https://github.com/adam900710/linux/tree/metadata_subpage_switch
>>>
>>
>> The Linux Asahi folks have a 16K page environment (M1 Macs)...
> 
> Su Yue kindly helped me testing 16K page size, and it's pretty OK there.
> 
> So I'm not that concerned.
> 
> It's 128K page size that I'm a little concerned, and I have not machine
> supporting that large page size to do the test.
> 
> Thanks,
> Qu

I'm happy to test things on 16K in the future if you need me to :-)

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
