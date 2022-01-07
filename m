From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] fs: btrfs: Disable BTRFS on platforms having 256K pages
Date: Fri, 7 Jan 2022 08:13:01 +0800
Message-ID: <db88497c-ea17-27ca-6158-2a987acb7a1c@gmx.com>
References: <a16c31f3caf448dda5d9315e056585b6fafc22c5.1623302442.git.christophe.leroy@csgroup.eu>
 <6c7a6762-6bec-842b-70b4-4a53297687d1@gmx.com>
 <CAEg-Je9UJDJ=hvLLqQDsHijWnxh1Z1CwaLKCFm+-bLTfCFingg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641514390;
        bh=EyPi8Y3Gc+gTu2ILQBh3edI82bKKE2zEKRdiyUFahW4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=RcqA07djH1Kg19mjjHZT9kQEF5PBB0i+eBHqAXaC6T9NjHBCkybTynF/giLuDnIBk
         o1hL4kgES4Z+FDB0zoVkVRjNS/wyuVImH+OQgV2PL8ZzWlZMoLIAl+pPrvfVK52dtb
         Xsa+hpVlC6iKG5amEr6vxBqPsdcEcJXZXxPodJTY=
Content-Language: en-US
In-Reply-To: <CAEg-Je9UJDJ=hvLLqQDsHijWnxh1Z1CwaLKCFm+-bLTfCFingg@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Neal Gompa <ngompa13@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, linux-hexagon@vger.kernel.org, Hector Martin <marcan@marcan.st>



On 2022/1/7 00:31, Neal Gompa wrote:
> On Wed, Jan 5, 2022 at 7:05 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>> Hi Christophe,
>>
>> I'm recently enhancing the subpage support for btrfs, and my current
>> branch should solve the problem for btrfs to support larger page sizes.
>>
>> But unfortunately my current test environment can only provide page siz=
e
>> with 64K or 4K, no 16K or 128K/256K support.
>>
>> Mind to test my new branch on 128K page size systems?
>> (256K page size support is still lacking though, which will be addresse=
d
>> in the future)
>>
>> https://github.com/adam900710/linux/tree/metadata_subpage_switch
>>
>
> The Linux Asahi folks have a 16K page environment (M1 Macs)...

Su Yue kindly helped me testing 16K page size, and it's pretty OK there.

So I'm not that concerned.

It's 128K page size that I'm a little concerned, and I have not machine
supporting that large page size to do the test.

Thanks,
Qu

>
> Hector, could you look at it too?
>
>
>
