From: David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] fs: btrfs: Disable BTRFS on platforms having 256K pages
Date: Fri, 11 Jun 2021 14:34:02 +0200
Message-ID: <20210611123402.GD28158@twin.jikos.cz>
References: <a16c31f3caf448dda5d9315e056585b6fafc22c5.1623302442.git.christophe.leroy@csgroup.eu>
Reply-To: dsterba@suse.cz
Mime-Version: 1.0
Return-path: <linux-btrfs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623415008;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WbubFKHB1YFq8+cLZPFZsL/iGgDagPXwRBHcKJ3qDmE=;
        b=2peLsmD6OKg84vX05jlKeSSzhc+WJwWLotAAvUINC/onEs9TZQ3AbPHeWdfS+bddiLLzh6
        0c23UqVPl326Qf2GLCycEtdoY9uZtjge95WU9F1EOEMHDadCrMP+/1vg8CqJ73tLjxiDvw
        Lz8qAG0S58lqlW3qCvtVoDZc1BMWInk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623415008;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WbubFKHB1YFq8+cLZPFZsL/iGgDagPXwRBHcKJ3qDmE=;
        b=3v38kvCKiCtteusW+zZk3tG/vFy89Y7uWUqGSygE7PibOC0N0H5mMQie3rH4X648s2bwn9
        4RHgSq2/8HIoKtBQ==
Content-Disposition: inline
In-Reply-To: <a16c31f3caf448dda5d9315e056585b6fafc22c5.1623302442.git.christophe.leroy@csgroup.eu>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-btrfs@vger.kernel.org, linux-hexagon@vger.kernel.org

On Thu, Jun 10, 2021 at 05:23:02AM +0000, Christophe Leroy wrote:
> With a config having PAGE_SIZE set to 256K, BTRFS build fails
> with the following message
> 
>  include/linux/compiler_types.h:326:38: error: call to '__compiletime_assert_791' declared with attribute error: BUILD_BUG_ON failed: (BTRFS_MAX_COMPRESSED % PAGE_SIZE) != 0
> 
> BTRFS_MAX_COMPRESSED being 128K, BTRFS cannot support platforms with
> 256K pages at the time being.
> 
> There are two platforms that can select 256K pages:
>  - hexagon
>  - powerpc
> 
> Disable BTRFS when 256K page size is selected.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

With updated changelog added to misc-next, thanks.
