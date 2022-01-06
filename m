From: Neal Gompa <ngompa13@gmail.com>
Subject: Re: [PATCH] fs: btrfs: Disable BTRFS on platforms having 256K pages
Date: Thu, 6 Jan 2022 11:31:04 -0500
Message-ID: <CAEg-Je9UJDJ=hvLLqQDsHijWnxh1Z1CwaLKCFm+-bLTfCFingg@mail.gmail.com>
References: <a16c31f3caf448dda5d9315e056585b6fafc22c5.1623302442.git.christophe.leroy@csgroup.eu>
 <6c7a6762-6bec-842b-70b4-4a53297687d1@gmx.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZM6UOM3FnObRgkqEaRi7ZwsD77LyLEAv2E7+Qwz8Kpo=;
        b=VFCxEpktrpxVRGftdbTMwrw0K0F4iRBgf/FyutcTsvjBshi4XyaAR9z8aQ1XSsuPMW
         XZwBWhC7xGFrRA7qJ7ZCdRCnCl3IG07J41NrYQOdtNeZqyCkfb5gxVv2gzovjf1S25Cj
         nJ29mE0DJcinUaYPSRFG5CMLPZ07BcCe7mxdeI68C44G5pvX4NxPtvOQ8OJOdUKqp5MW
         C5sEj1X1RkO53v91PxhkmXXMFrJzFHg/ztn4QrrH3hd7EKUzxrmaIm7JXC15fZEf4G8u
         1vEdnf77nA9yfZBXMbnpXAZTi/STZdYof23Fsi08VjH8kIwtknhGklWB+Jhh+1ZfaWgr
         yZlA==
In-Reply-To: <6c7a6762-6bec-842b-70b4-4a53297687d1@gmx.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, linux-hexagon@vger.kernel.org, Hector Martin <marcan@marcan.st>

On Wed, Jan 5, 2022 at 7:05 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
> Hi Christophe,
>
> I'm recently enhancing the subpage support for btrfs, and my current
> branch should solve the problem for btrfs to support larger page sizes.
>
> But unfortunately my current test environment can only provide page size
> with 64K or 4K, no 16K or 128K/256K support.
>
> Mind to test my new branch on 128K page size systems?
> (256K page size support is still lacking though, which will be addressed
> in the future)
>
> https://github.com/adam900710/linux/tree/metadata_subpage_switch
>

The Linux Asahi folks have a 16K page environment (M1 Macs)...

Hector, could you look at it too?



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
