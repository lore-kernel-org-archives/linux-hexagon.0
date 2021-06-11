From: David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] btrfs: Disable BTRFS on platforms having 256K pages
Date: Fri, 11 Jun 2021 15:21:22 +0200
Message-ID: <20210611132121.GF28158@twin.jikos.cz>
References: <a16c31f3caf448dda5d9315e056585b6fafc22c5.1623302442.git.christophe.leroy@csgroup.eu>
 <185278AF-1D87-432D-87E9-C86B3223113E@fb.com>
 <cdadf66e-0a6e-4efe-0326-7236c43b2735@csgroup.eu>
 <20210610162046.GB28158@suse.cz>
 <6769ED4C-15A8-4CFF-BF2B-26A5328257A0@fb.com>
Reply-To: dsterba@suse.cz
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623417847;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IoZe2Do+YjFfznb3FBAGTMrmvEaWFCHdUpFU1G49nbI=;
        b=DsPjPdR/cfZoznWMhaKw2jCReQocGLnq0vEnJz7X8/bGQYVgpxy7wp95U5fUoz1M7KM78/
        lO2UK4i5tLunQSK1zEYRN1rTnR+kGQ05PFOwnRnWD6Fd6xeLJGkm/Jf2XaAB9oJSQApAgB
        F2wxrLlTZqOTDKnNZkF7+OqUsTJI2GI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623417847;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IoZe2Do+YjFfznb3FBAGTMrmvEaWFCHdUpFU1G49nbI=;
        b=3WXO5EAErIRttTmkRzoLqskq1oqP9k1xWfNAPTGWce7kDcJB+FkFYeIsKAoU0vg9toUpFm
        f+ez2JLbfaxrODBA==
Content-Disposition: inline
In-Reply-To: <6769ED4C-15A8-4CFF-BF2B-26A5328257A0@fb.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Chris Mason <clm@fb.com>
Cc: "dsterba@suse.cz" <dsterba@suse.cz>, Christophe Leroy <christophe.leroy@csgroup.eu>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-btrfs <linux-btrfs@vger.kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>

On Fri, Jun 11, 2021 at 12:58:58PM +0000, Chris Mason wrote:
> > On Jun 10, 2021, at 12:20 PM, David Sterba <dsterba@suse.cz> wrote:
> > On Thu, Jun 10, 2021 at 04:50:09PM +0200, Christophe Leroy wrote:
> >> Le 10/06/2021 =E0 15:54, Chris Mason a =E9crit :
> >>>> On Jun 10, 2021, at 1:23 AM, Christophe Leroy <christophe.leroy@csgr=
oup.eu> wrote:
> > And there's no such thing like "just bump BTRFS_MAX_COMPRESSED to 256K".
> > The constant is part of on-disk format for lzo and otherwise changing it
> > would impact performance so this would need proper evaluation.
>=20
> Sorry, how is it baked into LZO?  It definitely will have performance imp=
lications, I agree there.

lzo_decompress_bio:

309         /*
310          * Compressed data header check.
311          *
312          * The real compressed size can't exceed the maximum extent len=
gth, and
313          * all pages should be used (whole unused page with just the se=
gment
314          * header is not possible).  If this happens it means the compr=
essed
315          * extent is corrupted.
316          */
317         if (tot_len > min_t(size_t, BTRFS_MAX_COMPRESSED, srclen) ||
318             tot_len < srclen - PAGE_SIZE) {
319                 ret =3D -EUCLEAN;
320                 goto done;
321         }
