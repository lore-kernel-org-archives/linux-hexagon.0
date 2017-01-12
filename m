From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: [PATCH v2 7/7] uapi: export all headers under uapi directories
Date: Thu, 12 Jan 2017 16:52:57 +0100
Message-ID: <464a1323-4450-e563-ff59-9e6d57b75959@6wind.com>
References: <bf83da6b-01ef-bf44-b3e1-ca6fc5636818@6wind.com>
 <1483695839-18660-1-git-send-email-nicolas.dichtel@6wind.com>
 <1483695839-18660-8-git-send-email-nicolas.dichtel@6wind.com>
 <20170109125638.GA15506@infradead.org>
Reply-To: nicolas.dichtel@6wind.com
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind-com.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:references:to:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=1XRdB6+woEoPIFIzdROV46XkV3VusOtCKknGiL09tVE=;
        b=qQiG+T9eXnUKXgRcmv1xurbYPI5bckmjW/HQqjnLycnlFZtWomM8iZPeOtq7glWUuY
         h4RhWcyldnUhY6m//U48ndkzAqlu77EbdnZPKcgi80TWKSEx1CuKb4SsOLMm5T6/KxAr
         4YdD/zWuleyPSLxbPjCPoodLJid/ZPgKsH2G1XyIzG5dWt6Gebuv8pX8KzdrPOsM2t4e
         a8kJAtxWBYyCmZPYBeisRkxSpCREDxSgvH+F8YYjh33QnnavdU4szKtvpecOoXqV9GKE
         GOTQgiCPJLHuSatc4XoPd3bqP9SrZzpgiCxkMR579Evj2EXQOqJ70tlHnx1Ih7EwuB3M
         QpSA==
In-Reply-To: <20170109125638.GA15506@infradead.org>
Sender: linux-alpha-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Christoph Hellwig <hch@infradead.org>
Cc: arnd@arndb.de, mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, uclinux-h8-devel@lists.sourceforge.jp, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, linux-am33-list@redhat.com, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-ar

Le 09/01/2017 =E0 13:56, Christoph Hellwig a =E9crit :
> On Fri, Jan 06, 2017 at 10:43:59AM +0100, Nicolas Dichtel wrote:
>> Regularly, when a new header is created in include/uapi/, the developer
>> forgets to add it in the corresponding Kbuild file. This error is usually
>> detected after the release is out.
>>
>> In fact, all headers under uapi directories should be exported, thus it's
>> useless to have an exhaustive list.
>>
>> After this patch, the following files, which were not exported, are now
>> exported (with make headers_install_all):
>=20
> ... snip ...
>=20
>> linux/genwqe/.install
>> linux/genwqe/..install.cmd
>> linux/cifs/.install
>> linux/cifs/..install.cmd
>=20
> I'm pretty sure these should not be exported!
>=20
Those files are created in every directory:
$ find usr/include/ -name '\.\.install.cmd' | wc -l
71
$ find usr/include/ -name '\.install' | wc -l
71

See also
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/scripts=
/Makefile.headersinst#n32


Thank you,
Nicolas
