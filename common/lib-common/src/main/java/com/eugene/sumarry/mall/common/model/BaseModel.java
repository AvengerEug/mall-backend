package com.eugene.sumarry.mall.common.model;

import java.io.Serializable;

public class BaseModel implements Serializable {

    private Long createdBy;
    private Long createdAt;
    private Long lastModifiedBy;
    private Long lastModifiedAt;
    private Boolean deleted;

    public Long getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(Long createdBy) {
        this.createdBy = createdBy;
    }

    public Long getCreatedAt() {
        return createdAt == null ? System.currentTimeMillis() : createdAt;
    }

    public void setCreatedAt(Long createdAt) {
        this.createdAt = createdAt;
    }

    public Long getLastModifiedBy() {
        return lastModifiedBy;
    }

    public void setLastModifiedBy(Long lastModifiedBy) {
        this.lastModifiedBy = lastModifiedBy;
    }

    public Long getLastModifiedAt() {
        return lastModifiedAt == null ? System.currentTimeMillis() : lastModifiedAt;
    }

    public void setLastModifiedAt(Long lastModifiedAt) {
        this.lastModifiedAt = lastModifiedAt;
    }

    public boolean isDeleted() {
        return deleted == null ? false : deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }
}
