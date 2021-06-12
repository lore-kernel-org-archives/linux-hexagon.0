From: "Brian Cain" <bcain@codeaurora.org>
Subject: RE: [PATCH] btrfs: Disable BTRFS on platforms having 256K pages
Date: Sat, 12 Jun 2021 09:44:05 -0500
Message-ID: <17a401d75f99$662cdc50$328694f0$@codeaurora.org>
References: <a16c31f3caf448dda5d9315e056585b6fafc22c5.1623302442.git.christophe.leroy@csgroup.eu>
 <185278AF-1D87-432D-87E9-C86B3223113E@fb.com>
 <cdadf66e-0a6e-4efe-0326-7236c43b2735@csgroup.eu>
Reply-To: bcain@codeaurora.org
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1623509055; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=RhtvN2QTW0JZFH6Rjd3vbX9yOl+YFdfv0SB17b2868c=;
 b=k0HU4kB5Cyx6FrM/UIBPtCIku1SKtbNjdCm9wl6ykARbxvMzDtHf5oqEpfpOJe17LrWSELhO
 OsEP+QVb+qX6QF4AFBPSkjfzRj+kgdlWXtNsFguU9/dT3Cp9FtzFU6WxOpqM5sIzToBLH9NY
 qG3COBjl82y1Nzt2ZNaMMdzX88M=
In-Reply-To: <cdadf66e-0a6e-4efe-0326-7236c43b2735@csgroup.eu>
Content-Language: en-us
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
Content-Type: text/plain; charset="utf-8"
To: 'Christophe Leroy' <christophe.leroy@csgroup.eu>, 'Chris Mason' <clm@fb.com>
Cc: linux-hexagon@vger.kernel.org, 'Josef Bacik' <josef@toxicpanda.com>, linux-kernel@vger.kernel.org, 'David Sterba' <dsterba@suse.com>, linuxppc-dev@lists.ozlabs.org, 'linux-btrfs' <linux-btrfs@vger.kernel.org>



> -----Original Message-----
> From: Christophe Leroy <christophe.leroy@csgroup.eu>
...
> Le 10/06/2021 =C3=A0 15:54, Chris Mason a =C3=A9crit :
> >
> >> On Jun 10, 2021, at 1:23 AM, Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
> >>
> >> With a config having PAGE_SIZE set to 256K, BTRFS build fails
> >> with the following message
> >>
> >> include/linux/compiler_types.h:326:38: error: call to
> '__compiletime_assert_791' declared with attribute error: BUILD_BUG_ON
> failed: (BTRFS_MAX_COMPRESSED % PAGE_SIZE) !=3D 0
> >>
> >> BTRFS_MAX_COMPRESSED being 128K, BTRFS cannot support platforms
> with
> >> 256K pages at the time being.
> >>
> >> There are two platforms that can select 256K pages:
> >> - hexagon
> >> - powerpc
> >>
> >> Disable BTRFS when 256K page size is selected.
> >>
> >
> > We=E2=80=99ll have other subpage blocksize concerns with 256K pages, =
but this
> BTRFS_MAX_COMPRESSED #define is arbitrary.  It=E2=80=99s just trying =
to have an
> upper bound on the amount of memory we=E2=80=99ll need to uncompress a =
single
> page=E2=80=99s worth of random reads.
> >
> > We could change it to max(PAGE_SIZE, 128K) or just bump to 256K.
> >
>=20
> But if 256K is problematic in other ways, is it worth bumping
> BTRFS_MAX_COMPRESSED to 256K ?
>=20
> David, in below mail, said that 256K support would require deaper =
changes. So
> disabling BTRFS
> support seems the easiest solution for the time being, at least for =
Stable (I
> forgot the Fixes: tag
> and the CC: to stable).
>=20
> On powerpc, 256k pages is a corner case, it requires customised =
binutils, so I
> don't think disabling
> BTRFS is a issue there. For hexagon I don't know.

Larger page sizes like this are typical for hexagon.  Disabling btrfs on =
hexagon seems appropriate.

-Brian

